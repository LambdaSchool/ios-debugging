# Debugging - Journal

## Introduction

This goal of this project is to debug the Journal project from the Core Data sprint. As this is a project specifically intended to help you practice your debugging skills and using the resources available to you, refrain from asking for help unless absolutely necessary.

## Instructions

Please fork and clone this repository. It contains the broken project that you should debug. As this is a project that you have worked on previously, do not use your own completed version of this project as you will gain nothing (in the long term) from referencing it.

As a recap, the project when working properly should:

- Allow the user to create journal entries that are saved to a Firebase Database and an on-device persistent store using Core Data
  - You will want to create your own Firebase database (or just use a new endpoint on the same one you've created in the past)
- The device's persistent store is synchronized with the Firebase Database. (When a journal entry is saved to the device's persistent store it gets sent to Firebase, and vice-versa.
