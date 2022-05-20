Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FEB52EE1F
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiETO00 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiETO0Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 10:26:24 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80873524F
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653056779;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=B94K503l7XtRdtAMd+10Ls9LaOI2UKAvLlbP676gbeI=;
    b=c5X3iv5yvRNE9cBsU5mPH5FkkFrmPojx00wC/0g7nzQJ6HXyH2q4sZci91ibHedY4P
    sIhBc8OaYaRShuxhQQACybSyQYmqUhxqbqSANGk4S7PPbqCXB+HXB0b3N12gT/WBlnIg
    59ETqFDsHMyt90CgBo7vqYuOUGtvH8opv4EWjGRK2qmsfP43BTscNSiDtpmB8ep/kp7M
    ZxhenEzLuiqPK8UZEpyXNDqgwllkkgGh8co3G0puefrseGlxmGW9XwIns4nzaazTh3Ei
    t1xjLWAzA1JpyRPJctkgiNH5BOBiijwxWqb6s60SkN8YfrLan3NSxXI+Vi1FceAkCHef
    CMag==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id Y03eaey4KEQIQD8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 16:26:18 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com,
        nramas@linux.microsoft.com
Cc:     linux-integrity@vger.kernel.org, Thore Sommer <public@thson.de>
Subject: [PATCH 3/3] dm ima: add documentation target update event
Date:   Fri, 20 May 2022 16:26:05 +0200
Message-Id: <20220520142605.270625-4-public@thson.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520142605.270625-1-public@thson.de>
References: <20220520142605.270625-1-public@thson.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.36.0

