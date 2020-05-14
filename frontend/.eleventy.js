const CleanCSS = require("clean-css");

module.exports = function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy({ "src/common": "/" });
  eleventyConfig.addPassthroughCopy("src/fonts");
  eleventyConfig.addPassthroughCopy("src/images");
  eleventyConfig.addFilter("cssmin", function (code) {
    return new CleanCSS({}).minify(code).styles;
  });

  return {
    dir: { input: "src", output: "dist", data: "_data" },
    passthroughFileCopy: true,
    templateFormats: ["njk", "css"],
    htmlTemplateEngine: "njk",
  };
};
