Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D569717D50A
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Mar 2020 18:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgCHREa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Mar 2020 13:04:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726338AbgCHREa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Mar 2020 13:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583687069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xCWfIVVtXcNrPtfCAElXYhujkDeI7te8IIcxIOU/lhc=;
        b=c2TdsSxA3pesaEURBvWFkLJS1Bk59+nDsuRko2oTc5TFWgdU3WXc5mlDvo1bXwzN/LLEBL
        C94qdSmBJ4HARXtP64oYgAszbtL7I1exJ76V0SSHEnC7eqRuo95W79w9AbmshxD61ElhXd
        v1zWvLkchJHfDlb6Yo7R0NfOYJIQ3eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-9pF2p6WgPbuuHt77AJVMew-1; Sun, 08 Mar 2020 13:04:27 -0400
X-MC-Unique: 9pF2p6WgPbuuHt77AJVMew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C2081005513;
        Sun,  8 Mar 2020 17:04:25 +0000 (UTC)
Received: from llong.com (ovpn-120-251.rdu2.redhat.com [10.10.120.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ADEF5D9C5;
        Sun,  8 Mar 2020 17:04:19 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] KEYS: Read keys to internal buffer & then copy to userspace
Date:   Sun,  8 Mar 2020 13:04:08 -0400
Message-Id: <20200308170410.14166-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v2:
 - Handle NULL buffer and buflen properly in patch 1.
 - Fix a bug in big_key.c.
 - Add patch 2 to handle arbitrary large user-supplied buflen.

The current security key read methods are called with the key semaphore
held.  The methods then copy out the key data to userspace which is
subjected to page fault and may acquire the mmap semaphore. That can
result in circular lock dependency and hence a chance to get into
deadlock.

To avoid such a deadlock, an internal buffer is now allocated for getting
out the necessary data first. After releasing the key semaphore, the
key data are then copied out to userspace sidestepping the circular
lock dependency.

The keyutils test suite was run and the test passed with these patchset
applied without any falure.

Waiman Long (2):
  KEYS: Don't write out to userspace while holding key semaphore
  KEYS: Avoid false positive ENOMEM error on key read

 include/linux/key-type.h                  |  2 +-
 security/keys/big_key.c                   | 11 ++---
 security/keys/encrypted-keys/encrypted.c  |  7 ++-
 security/keys/keyctl.c                    | 54 ++++++++++++++++++++++-
 security/keys/keyring.c                   |  6 +--
 security/keys/request_key_auth.c          |  7 ++-
 security/keys/trusted-keys/trusted_tpm1.c | 14 +-----
 security/keys/user_defined.c              |  5 +--
 8 files changed, 68 insertions(+), 38 deletions(-)

-- 
2.18.1

