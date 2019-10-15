Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31802D845A
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 01:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJOXRy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 19:17:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55626 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfJOXRy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 19:17:54 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B06220B71C6;
        Tue, 15 Oct 2019 16:17:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B06220B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571181473;
        bh=CclEh5Td/ZLrZKFXywNwaVVFQIwWJzZF/Y0wTbXiOg0=;
        h=From:To:Cc:Subject:Date:From;
        b=qjKjRqNx1O/KLkXjDfBxZa5ZGQO7RL1oxJf+W4AMKMRBZY97VI1uooYc8amKNiANn
         t2VUrVWQzeClRvpJCnJ9kX2Nx46FUx9yVy2fpAMBj7+vpAppW5AZCQf/sHtIJMK7HD
         tPh0VCwBYAENZOy8FceH3terW76sMzTFcZbodVnE=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Subject: [PATCH v0 0/1] KEYS: LSM Hook for key_create_or_update
Date:   Tue, 15 Oct 2019 16:17:49 -0700
Message-Id: <20191015231750.25992-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a LSM Hook for key_create_or_update function. The motive behind
this change is enable subsystems to receive notification when
a new key is created or updated. IMA will be one of the subsystems
that will use this hook to measure the newly created key.

Lakshmi Ramasubramanian (1):
  KEYS: LSM Hook for key_create_or_update

 certs/system_keyring.c            | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h     |  4 ++++
 include/linux/ima.h               |  8 ++++++++
 include/linux/lsm_hooks.h         | 14 ++++++++++++++
 include/linux/security.h          | 10 ++++++++++
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 19 +++++++++++++++++++
 security/keys/key.c               |  8 ++++++++
 security/security.c               | 11 +++++++++++
 9 files changed, 98 insertions(+)

-- 
2.17.1
