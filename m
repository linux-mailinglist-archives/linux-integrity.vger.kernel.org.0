Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5692023A93A
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgHCPP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2559 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727928AbgHCPP5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B0F94AD80610FEEC076B;
        Mon,  3 Aug 2020 16:15:54 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 16:15:54 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 17:15:53 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
Subject: [RFC][PATCH 0/3] ima: Digest Lists extension
Date:   Mon, 3 Aug 2020 17:13:10 +0200
Message-ID: <20200803151313.17510-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi everyone

before sending the full patch set which adds support for digest lists,
I would like to have an early review of the patches which introduce new
behavior for measurement, appraisal and EVM, so that we can identify
potential problems. The patches wouldn't alter existing behavior unless
explicitly requested by the user with additional kernel options.


========
Overview
========

Digest lists are a list of reference values for files and metadata, which
are preloaded early in the boot process so that can be compared with
calculated digest of files and metadata, when they are verified. If there
is a match, and the user enabled the feature, IMA and EVM behaviors are
modified in the following way:

- Measurement: adding ima_digest_list_pcr=<PCR> will cause the creation of
  an alternative measurement list, with the PCR specified, which includes
  only the measurement of the digest lists and of the files for which the
  digest has not be found among the preloaded ones. Both the standard and
  the alternative measurement list can be created by adding '+' before PCR.

- Appraisal: adding ima_appraise_digest_list=digest will grant access to
  the files whose digest is found, until EVM is initialized. Adding
  ima_appraise_digest_list=digest-nometadata will extend the usability of
  digest lists also after EVM is initialized. It is the least secure
  option, as it grants access to files without verifying metadata and would
  require the user to trust xattr values at first use. These files can be
  easily distinguished from others, as IMA at file close assigns to them a
  different security.ima type. Choosing this option might be useful if the
  only available reference values are for file content.

- EVM: a new type for security.evm has been introduced to calculate the
  metadata digest in the same way as for portable signatures and to search
  it in the digest lists. EVM reports successful verification if metadata
  digest is found.


========
Benefits
========

The main benefit of this extension is to maintain a stable PCR which can be
used for sealing of data and keys. The PCR maintained by the extension
changes, after the initial measurement of digest lists, only if an unknown
file is measured, and would work as an effective way to revoke access to
sensitive information protected by the TPM.

If a TPM key is bound to the stable PCR, and that key is used to establish
a TLS communication, remote peers would know that the system accessed
unknown files as, after revocation, the TPM would prevent the system from
performing the TLS protocol.

On the other end, recording only unknown files means losing information
about those that are in the digest lists. A verifier would not known
whether or not those files have been accessed. Given that both the standard
and the alternative measurement list can be created at the same time, one
can use the latter for normal operation and the former for a more precise
assessment for example due to suspicious activity.

Compared to the approach of measuring signing keys, digest lists have finer
granularity. The former represents all files signed with the measured key,
the latter only the files in a digest list, e.g. those belonging to a
package, container image, etc. Due to finer granularity, revocation would
be easier. In the future, a rollback prevention mechanism will prevent
digest lists of old package versions to be loaded again in the kernel. If
an old file will be accessed, it will be treated like an unknown file and a
new measurement entry will be created.

Given that software updates would also change the stable PCR, both
solutions can be combined together: measure the signing key used to verify
digest lists, and use digest lists to decide whether files should be added
to the measurement list. 

For appraisal and metadata verification, having a signed list of many
digests is more efficient than signing individual files, in terms of space
required to store the signatures and computation required for verification.


=========
Lifecycle
=========

From the lifecycle point of view, managing digest lists is feasible and
could be achieved without modification of existing building
infrastructures. I created a new project in the SUSE build service:

https://build.opensuse.org/project/show/home:roberto.sassu:branches:openSUSE:Leap:15.2

which automatically generates digest lists every time a package is built.
To achieve this, I modified some packages, such as rpm and
pesign-obs-integration, and added new ones, such as digest-list-tools and
brp-digest-list.

Then, I created a new project to generate an image suitable for execution
with KVM:

https://build.opensuse.org/project/show/home:roberto.sassu:branches:openSUSE:Templates:Images:15.2

This project generates an openSUSE Leap 15.2 JeOS image, which can be
downloaded at:

https://download.opensuse.org/repositories/home:/roberto.sassu:/branches:/openSUSE:/Templates:/Images:/15.2/images/

As for IMA signatures, an rpm plugin is responsible to perform additional
configuration when packages are installed. It extracts the header from the
package and converts the PGP signature to an IMA signature, so it can be
verified without additional modification of the kernel.


=======
Testing
=======

With the image, it is possible to easily evaluate the new functionality.
The second boot menu entry should be selected to enable usage of digest
lists for measurement and appraisal.


1. Show measurement list with predictable PCR:

# cat /sys/kernel/security/ima/ascii_runtime_measurements

11 <digest> ima-sig sha256:<digest> boot_aggregate
11 <digest> ima-sig sha256:<digest> .../0-parser_list-compact-libexec <sig>
11 <digest> ima-sig sha256:<digest> .../0-metadata_list-compact-digest-list-tools-0.3.93-lp152.20.5.x86_64 <sig>
11 <digest> ima-sig sha256:<digest> .../0-metadata_list-rpm-xz-5.2.3-lp152.6.1.x86_64 <sig>
...

The filename format is 0-<digest type>-<format>-<dir/package>

Every file is recognized, the measurement list contains only digest lists.
With appraisal enabled, unknown files cannot be accessed (with a patch) and
they are not added to the measurement list.

# echo test > script.sh
# chmod +x script.sh
# ./script.sh 
-bash: ./script.sh: Permission denied

# cat /sys/kernel/security/ima/ascii_runtime_measurements


2. Show measurement entry creation for unknown files:

Replace ima_appraise=enforce-evm with ima_appraise=log-evm in the kernel
command line of the second boot menu entry (the -evm suffix means that
uninitialized EVM is considered as an error).

If the unknown script is executed again, this time a new measurement entry
is created.

# cat /sys/kernel/security/ima/ascii_runtime_measurements
...
11 <digest> ima-sig sha256:<digest> /root/script.sh


3. Show file metadata protection

Reboot the system with ima_appraise=enforce-evm in the kernel command line.

A new policy option called 'metadata_immutable' has been introduced to
ensure that only binaries with verified and immutable metadata are
executed.

# cat
^C
# chmod 777 /bin/cat
# cat
-bash: /usr/bin/cat: Permission denied
# chmod 755 /bin/cat
# cat
^C



Please have a look at the patches or try the image. Any feedback is very
much appreciated.

Roberto Sassu (3):
  ima: Add support for measurement with digest lists
  ima: Add support for appraisal with digest lists
  evm: Add support for digest lists of metadata

 .../admin-guide/kernel-parameters.txt         | 18 ++++
 security/integrity/evm/evm_crypto.c           |  9 +-
 security/integrity/evm/evm_main.c             | 82 +++++++++++++++++--
 security/integrity/ima/ima.h                  | 15 ++--
 security/integrity/ima/ima_api.c              | 42 ++++++++--
 security/integrity/ima/ima_appraise.c         | 74 +++++++++++++++--
 security/integrity/ima/ima_digest_list.c      | 25 ++++++
 security/integrity/ima/ima_init.c             |  2 +-
 security/integrity/ima/ima_main.c             | 24 +++++-
 security/integrity/ima/ima_policy.c           |  3 +-
 security/integrity/integrity.h                |  2 +
 11 files changed, 263 insertions(+), 33 deletions(-)

-- 
2.27.GIT

