Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42116100EDD
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2019 23:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfKRWi0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 17:38:26 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50916 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWi0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 17:38:26 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id DD84420B7185;
        Mon, 18 Nov 2019 14:38:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD84420B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574116703;
        bh=+9WOl5hgywXH9MFFO6uRstKlAc68Aw0vEO7Qs9WEg8k=;
        h=From:To:Cc:Subject:Date:From;
        b=gRFQnKirJxaBuUB26kRNKNhe5YqVmmPCAadmC+pi/GnziLP3WvNzbMLhUDlRq0Rgp
         /ZzSV8UD+fKe7GW/39GiZFszLCBRNYkKdIAzgFBN93F+dHHNlKFYsKYwhJUgBqplBd
         eFwkWjEqJDIgRkwa/UbHtrpwJLMlnPggGxm4bt3Q=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v8 0/5] KEYS: Measure keys when they are created or updated
Date:   Mon, 18 Nov 2019 14:38:13 -0800
Message-Id: <20191118223818.3353-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys created or updated in the system are currently not measured.
Therefore an attestation service, for instance, would not be able to
attest whether or not the trusted keys keyring(s), for instance, contain
only known good (trusted) keys.

IMA measures system files, command line arguments passed to kexec,
boot aggregate, etc. It can be used to measure keys as well.
But there is no mechanism available in the kernel for IMA to
know when a key is created or updated.

This change aims to address measuring keys created or updated
in the system.

To achieve the above the following changes have been made:

 - Added a new IMA hook namely, ima_post_key_create_or_update, which
   measures the key. This IMA hook is called from key_create_or_update
   function. The key measurement can be controlled through IMA policy.

   A new IMA policy function KEY_CHECK has been added to measure keys.
   "keyrings=" option can be specified for KEY_CHECK to limit
   measuring the keys loaded onto the specified keyrings only.

   # measure keys loaded onto any keyring
   measure func=KEY_CHECK

   # measure keys loaded onto the IMA keyring only
   measure func=KEY_CHECK keyring=".ima"

   # measure keys on the BUILTIN and IMA keyrings into a different PCR
   measure func=KEY_CHECK keyring=".builtin_trusted_keys|.ima" pcr=11

Testing performed:

  * Booted the kernel with this change.
  * When KEY_CHECK policy is set IMA measures keys loaded
    onto any keyring (keyrings= option not specified).
  * Keys are not measured when KEY_CHECK is not set.
  * When keyrings= option is specified for KEY_CHECK then only the keys
    loaded onto a keyring specified in the option is measured.
  * Added a new key to a keyring.
    => Added keys to .ima and .evm keyrings.
  * Added the same key again.
    => Add the same key to .ima and .evm keyrings.

Change Log:

  v8:

  => Updated ima_match_keyring() function to check for
     whole keyring name match.
  => Used CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE instead of
     CONFIG_KEYS to build ima_asymmetric_keys.c and enable
     the IMA hook to measure keys since this config handles
     the required build time dependencies better.
  => Updated patch description to illustrate verification
     of key measurement.

  v7:

  => Removed CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS option and used
     CONFIG_KEYS instead for ima_asymmetric_keys.c
  => Added the patches related to "keyrings=" option support to
     this patch set.

  v6:

  => Rebased the changes to v5.4-rc7
  => Renamed KEYRING_CHECK to KEY_CHECK per Mimi's suggestion.
  => Excluded the patches that add support for limiting key
     measurement to specific keyrings ("keyrings=" option
     for "measure func=KEY_CHECK" in the IMA policy).
     Also, excluded the patches that add support for deferred
     processing of keys (queue support).
     These patches will be added in separate patch sets later.

  v5:

  => Reorganized the patches to add measurement of keys through
     the IMA hook without any queuing and then added queuing support.
  => Updated the queuing functions to minimize code executed inside mutex.
  => Process queued keys after custom IMA policies have been applied.

  v4:

  => Rebased the changes to v5.4-rc3
  => Applied the following dependent patch set first
     and then added new changes.
  https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
  => Refactored the patch set to separate out changes related to
     func KEYRING_CHECK and options keyrings into different patches.
  => Moved the functions to queue and dequeue keys for measurement
     from ima_queue.c to a new file ima_asymmetric_keys.c.
  => Added a new config namely CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
     to compile ima_asymmetric_keys.c

  v3:

  => Added KEYRING_CHECK for measuring keys. This can optionally specify
     keyrings to measure.
  => Updated ima_get_action() and related functions to return
     the keyrings if specified in the policy.
  => process_buffer_measurement() function is updated to take keyring
     as a parameter. The key will be measured if the policy includes
     the keyring in the list of measured keyrings. If the policy does not
     specify any keyrings then all keys are measured.

  v2:

  => Per suggestion from Mimi reordered the patch set to first
     enable measuring keys added or updated in the system.
     And, then scope the measurement to keys added to 
     builtin_trusted_keys keyring through ima policy.
  => Removed security_key_create_or_update function and instead
     call ima hook, to measure the key, directly from 
     key_create_or_update function.

  v1:

  => LSM function for key_create_or_update. It calls ima.
  => Added ima hook for measuring keys
  => ima measures keys based on ima policy.

  v0:

  => Added LSM hook for key_create_or_update.
  => Measure keys added to builtin or secondary trusted keys keyring.


Lakshmi Ramasubramanian (5):
  IMA: Add KEY_CHECK func to measure keys
  IMA: Define an IMA hook to measure keys
  KEYS: Call the IMA hook to measure keys
  IMA: Add support to limit measuring keys
  IMA: Read keyrings= option from the IMA policy

 Documentation/ABI/testing/ima_policy         |  17 +++-
 include/linux/ima.h                          |  13 +++
 security/integrity/ima/Makefile              |   1 +
 security/integrity/ima/ima.h                 |   9 +-
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |   4 +-
 security/integrity/ima/ima_asymmetric_keys.c |  57 +++++++++++
 security/integrity/ima/ima_main.c            |   9 +-
 security/integrity/ima/ima_policy.c          | 100 +++++++++++++++++--
 security/keys/key.c                          |   7 ++
 10 files changed, 205 insertions(+), 20 deletions(-)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

-- 
2.17.1

