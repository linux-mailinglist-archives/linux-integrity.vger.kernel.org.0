Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BCD486B42
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jan 2022 21:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbiAFUe4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jan 2022 15:34:56 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:40779 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243912AbiAFUe4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jan 2022 15:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641501295;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FC1evWUMQLTdet9/v+dR14paNSJb6IQ45Isfnvwzk+w=;
    b=UjqznpGmCQS7qOp+W8Uuytpt8xeJYMuv2iMnUGIzEwui5j4RQD6KS8cATKJqcZunwz
    aevNmUfcdT5YQIlXDQTW9sDAZd2rUKc6yIMDxA664tUpXOfSiGMtHXtGQ/KaIeO3GuRK
    khe2/Cp0yiIP+4Jax2dGmuT15I9+sWOdyA1yZ272Cdjv//dsuiRMY/O+Sj9Tp2BLviPm
    xjYVmYolcGOvqB8q9peSZ1sSXJQMPfryJ7F4CJrh7z9RL924fbE7vkyzaHqhRTXL0rG6
    G9Le9CBGQa7fcFE1VqIUzzi/sP4e1VNUCeV3EZInbe6ts804bWhYknyAULDwXWZFEa9r
    oN2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.37.6 DYNA|AUTH)
    with ESMTPSA id k3f463y06KYt05h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Jan 2022 21:34:55 +0100 (CET)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Thore Sommer <public@thson.de>
Subject: [RFC PATCH 3/3] dm ima: add documentation target update event
Date:   Thu,  6 Jan 2022 21:34:36 +0100
Message-Id: <20220106203436.281629-4-public@thson.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106203436.281629-1-public@thson.de>
References: <20220106203436.281629-1-public@thson.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The dm_target_update event can be triggered by targets to remeasure their
state to reflect that change also in IMA.

This is event is currently only supported by verity.

Signed-off-by: Thore Sommer <public@thson.de>
---
 .../admin-guide/device-mapper/dm-ima.rst      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/admin-guide/device-mapper/dm-ima.rst b/Documentation/admin-guide/device-mapper/dm-ima.rst
index a4aa50a828e0..ac9418ea99d3 100644
--- a/Documentation/admin-guide/device-mapper/dm-ima.rst
+++ b/Documentation/admin-guide/device-mapper/dm-ima.rst
@@ -93,6 +93,7 @@ Following device state changes will trigger IMA measurements:
  #. Device remove
  #. Table clear
  #. Device rename
+ #. Target update
 
 1. Table load:
 ---------------
@@ -321,6 +322,38 @@ The IMA measurement log has the following format for 'dm_device_rename':
  new_name=linear\=2,new_uuid=1234-5678;
  current_device_capacity=1024;
 
+6. Target update:
+------------------
+When a target changes updates its table it can trigger an remeasurement of that table.
+
+This is currently only implemented for 'verity' targets to detect measure corruption occurrences.
+Note that the active table hash of the device does not get updated.
+
+The IMA measurement log has the following format for 'dm_target_update':
+
+::
+
+ EVENT_NAME := "dm_target_update"
+ EVENT_DATA := <dm_version_str> ";" <device_active_metadata> ";" <target_data_row> ";"
+
+ dm_version_str := As described in the 'Table load' section above.
+ device_active_metadata := Device metadata that reflects the currently loaded active table.
+                           The format is same as 'device_metadata' described in the 'Table load' section above.
+ target_data_row
+ E.g: if a verity device gets corrupted then IMA ASCII measurement log will have an entry with:
+ (converted from ASCII to text for readability)
+
+ 10 1cc9c660afb7fddd1b7167f0c4e997ebca8b1c09 ima-buf sha256:e991f7692724257701c8e652682bd3246837ed2d655407b9e9f5a5b469e6c75b
+ dm_target_update
+ dm_version=4.45.0;
+ name=test,uuid=CRYPT-VERITY-e0d2a85fd61e41238174adaa32d296fe-test,major=253,minor=0,minor_count=1,num_targets=1;
+ target_index=0,target_begin=0,target_len=8,target_name=verity,target_version=1.8.0,hash_failed=C,
+ verity_version=1,data_device_name=7:1,hash_device_name=7:0,verity_algorithm=sha256,
+ root_digest=8c2eff0b45fc9815b94350f7a913683ef34085c734229bcf1345c31b07ac61b8,
+ salt=63010b7c63e28e6929a2f020dc71c97a0660a9f377a83c674a62feb01c5ca6b3,
+ ignore_zero_blocks=n,check_at_most_once=n;
+
+
 Supported targets:
 ==================
 
-- 
2.34.1

