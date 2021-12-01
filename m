Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A39464EB6
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 14:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbhLANYY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 08:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhLANYX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 08:24:23 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5853C061574
        for <linux-integrity@vger.kernel.org>; Wed,  1 Dec 2021 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638364860;
        bh=TEUbT8YAZQdRQS5d9YMYuRhKTaAeqsYeGDHBuzE0N3g=;
        h=From:To:Subject:Date:Message-Id:From;
        b=UwTArRZfauO6hNOXvoyOJfW1v8ek0HZNjWUNx+ioJ9vnjXANkveq/7MHlOkGzE3pE
         fL8NmK2Dm8yR0DPwXZ/GQYaAH7QILX1YM/xyVT4jZuQrA8hLynEzSNGfblbDhFlAg9
         JzXI2hIVIvFpbqYxkQ2lYB5UdqVX8bG/j4fwBiLc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CB4251280403;
        Wed,  1 Dec 2021 08:21:00 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3maekpuAqkZP; Wed,  1 Dec 2021 08:21:00 -0500 (EST)
Received: from rainbow.int.hansenpartnership.com (unknown [153.66.140.204])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7454C12803C3;
        Wed,  1 Dec 2021 08:20:59 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     containers@lists.linux.dev, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC v2 0/3] Namespace IMA log entries
Date:   Wed,  1 Dec 2021 13:20:41 +0000
Message-Id: <20211201132044.566371-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v2: drop the user namespace uuid and instead add an IMA specific label
(residing in an opaque IMA structure pointed to by the user_ns) that
is settable once before use, but if not set reverts to a randomly
generated uuid.

Over the past five years there have been several attempts to namespace
IMA [1,2,3].  All of them were eventually fairly huge patch series,
which try to solve every issue and potential issue all at once, making
them incredibly difficult to review and highly dependent on an array
of non-IMA features which causes huge upporting difficulty as the
patch progresses.  Given this, I thought we'd try a different way:
introduce a minimal namespacing of IMA and try to build on it in
subsequent patches.

This first patch set namespaces IMA by tying it to the user
namespace. We're still discussing whether this is a good idea, so I'll
pass on the justification and note that the only addition is a
ima_ns_info pointer which points to a structure that has a lifetime
longer than the namespace, so the whole machinery for managing this
could be transferred to a different namespace.  Within this pointer is
a label for the IMA namespace, which has a set API (but no exposure in
the current patch se) and if the label isn't set before the namespace
causes an IMA log entry, a uuid is placed into the label.

All this patch set does is add a new template 'ima-ns' which includes
the namespace label (added by the first patch) in the IMA log.  Using
uuids gives us probabalistically unique identifiers for all namespaces
without having to check them for uniqueness.

Once we have the container being logged, it stands to reason that the
ima inode cache needs to record one event per namespace per inode
instead of the one global event per inode, so if I enter the ima
namespace and execute the same measured command, it will log again
with the new namespace uuid even if the hash is the same:

 > ls
 > grep ls /sys/kernel/security/integrity/ima/ascii_runtime_measurements
10 c70c7b851f83c8c71ee7b508c8468383c0d2c154 ima-ns sha256:1f7f27ef1052e33731c9ff56a36ac3af4437e3f95ad55f6813c320b087b5d356 /usr/bin/ls 6582e360-1354-42b9-a6ef-ee1993d982da
 > unshare --user -r
 # ls
 # exit
 > grep ls /sys/kernel/security/integrity/ima/ascii_runtime_measurements
 10 c70c7b851f83c8c71ee7b508c8468383c0d2c154 ima-ns sha256:1f7f27ef1052e33731c9ff56a36ac3af4437e3f95ad55f6813c320b087b5d356 /usr/bin/ls 6582e360-1354-42b9-a6ef-ee1993d982da
10 144a73d85e9cf999c4abbc99f3c41e9422c8016e ima-ns sha256:1f7f27ef1052e33731c9ff56a36ac3af4437e3f95ad55f6813c320b087b5d356 /usr/bin/ls e496e384-4133-4d57-b93a-1812b83badf2

Note that this namespacing if the iint cache is in the third patch and
could be dropped if there's huge opposition.

Some things to note are that the IMA securityfs entries aren't
virtualized.  This is planned for a follow up patch (so currently the
admin can't even view the ima log in the container).  Everything
that's logged goes through the main IMA log and the physical TPM.
This means that the admin of the physical system can attest to the
log, but the containers would have to trust the admins attestation of
their log pieces.  The initial IMA policy is also inherited from the
physical system and can't currently be changed.

The rough plan of action for follow up patches is

1. Namespace securityfs so container admin can read the IMA files like
   log which would only show entries related to the container (so only
   entries generated by the current and all child namespaces) and
   policy.

2. Add per namespace policies by writing to the policy file in the
   container.  Obviously implementation of this would have to preserve
   the security of the system, so the new namespace couldn't stop
   logging something the physical host required to be logged, but it
   could add additional classes of things to log.

3. Add the ima keyrings and the ability to appraise inside the container.

There could be other phases beyond this, including possibly optionally
attaching a vtpm to the container to provide local quotes but this
should be need driven.

Some non problems of this approach are:

* The continuous growth of the IMA log.  This is already a problem
  with non-namespaced IMA.  One can argue that the above
  implementation makes the problem worse, but it is unarguable that if
  the problem were solved generally it would no logner be an issue for
  containers.

* attesting to the in-container IMA log.  Given it's being logged
  through the physical TPM, the physical system owner will have to
  publish a mechanism for attesting to particular container entries of
  the log.

[1] https://lore.kernel.org/all/20200818152037.11869-1-krzysztof.struczynski@huawei.com
[2] https://lore.kernel.org/all/20180511144230.75384-1-stefanb@linux.vnet.ibm.com
[3] https://lore.kernel.org/all/1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com

James

---

James Bottomley (3):
  userns: add ima_ns_info field containing a settable namespace label
  ima: show the namespace label in the ima-ns template
  ima: make the integrity inode cache per namespace

 include/linux/ima.h                       |  15 +-
 include/linux/user_namespace.h            |   7 +
 kernel/user.c                             |   1 +
 kernel/user_namespace.c                   |   6 +
 security/integrity/iint.c                 |   4 +-
 security/integrity/ima/Kconfig            |   6 +-
 security/integrity/ima/Makefile           |   2 +-
 security/integrity/ima/ima.h              |  26 +++-
 security/integrity/ima/ima_api.c          |   7 +-
 security/integrity/ima/ima_main.c         |  21 +--
 security/integrity/ima/ima_ns.c           | 169 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |   2 +-
 security/integrity/ima/ima_template.c     |   6 +-
 security/integrity/ima/ima_template_lib.c |  17 +++
 security/integrity/ima/ima_template_lib.h |   4 +
 security/integrity/integrity.h            |  11 +-
 16 files changed, 284 insertions(+), 20 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns.c

-- 
2.33.0

