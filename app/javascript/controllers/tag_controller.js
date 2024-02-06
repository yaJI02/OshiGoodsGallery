import { Controller } from "@hotwired/stimulus";
import Tagify from "@yaireo/tagify";

export default class extends Controller {
  connect() {
    this.applyTagify("post_place");
    this.applyTagify("post_content_tag");
    this.applyTagify("post_merchandise_tag");
  }

  applyTagify(inputId) {
    var input = document.getElementById(inputId),
      tagify = new Tagify(input, {
        whitelist: [],
        maxTags: 10,
        dropdown: {
          maxItems: 10,
          classname: "tags-look",
          enabled: 0,
          closeOnSelect: false
        },
      });

    fetch(`/tags/get_all_${inputId}`)
      .then((response) => response.json())
      .then((tags) => {
        tagify.whitelist = tags;
      })
      .catch((error) => console.error("Error fetching tags:", error));
  }
};
