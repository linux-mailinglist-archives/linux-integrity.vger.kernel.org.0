Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B407C289988
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgJIUO0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 16:14:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:58066 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgJIUO0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 16:14:26 -0400
IronPort-SDR: bsY2K8rwrGA3OXjmhN7svQU4qo1suUhOGPQza7mhMWH7Or4xQoaZHdovQMgWSK2vxAjFTZOJvJ
 seA6hp1/VDAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="250228369"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="250228369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:14:24 -0700
IronPort-SDR: IXEGMVyDlvLok8NfI+TgUT2zaqZMMuibHZuc/fyZxHw/Tz+YeeNyn/uSHL8eXxwdNMNFzoQQ7K
 WzMGn3a/SXLg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529062329"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:14:24 -0700
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-integrity@vger.kernel.org (open list:KEYS-TRUSTED),
        keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH RFC PKS/Trusted keys 0/2] trusted keys: Add PKS protection to trusted keys
Date:   Fri,  9 Oct 2020 13:14:08 -0700
Message-Id: <20201009201410.3209180-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Leaking a trusted key would be a critical security issue.  PKS provides an
additional mechanism to restrict access to the memory holding trusted keys.

This series depends on the core patches and PMEM PKS API change submitted
separately.

	Core PKS support:
	https://lore.kernel.org/lkml/20201009194258.3207172-1-ira.weiny@intel.com/

	PKS/PMEM support (includes global API change):
	https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/

And contained in the git tree here:

	https://github.com/weiny2/linux-kernel/tree/pks-rfc-v3


Provide a skeleton of a new allocation call which provides a PKS restricted
mapping of the trusted key memory.  Allocate a PKS domain (pkey), create a
mapping with that key, and enable/disable access as needed to that mapping.

The issue with this approach is that it fails to protect the direct mapping.
The current ideas to protect the direct mapping are:

	1) Do nothing.
	2) Allow the direct map to be fragmented through a set_memory_pks() like call.
	3) Piggy back on secretmem's solution to map out some direct map memory
	   then overlay that with PKS.
	4) Integrate PKS into secretmem and use this enhanced secretmem for
	   trusted keys.

Doing nothing is not really providing the level of security we need for this
use case.

Allowing the direct map to fragment may be ok as trusted keys don't use a lot
of pages and are usually allocated early in the system boot but that is not
always the case.  In addition the current code could be made
to not allocating an entire page for each key to limit the number of pages, and
therfore the fragmentation, needed.

The use of secretmem is complicated by its newness but whatever solution is
used there should be used here.  And probalby through some nice interface.

The final thought is to determine if a 'general allocator' for PKS protected
memory should be developed at all.  The current implementation is limited in
key space and so a higher bar to entry may be a good thing.  On the other hand,
dealing with mappings for the average driver writer is complicated and doing
this wrong could result in a false sense of 'security'.


Elena Reshetova (1):
  keys/trusted: protect trusted keys using PKS

Ira Weiny (1):
  vmalloc: Add vmalloc_pks() call

 Documentation/core-api/protection-keys.rst |  4 +
 include/keys/trusted-type.h                |  2 +-
 include/keys/trusted_tpm.h                 | 15 ++++
 include/linux/vmalloc.h                    |  1 +
 mm/vmalloc.c                               | 28 +++++++
 security/keys/encrypted-keys/encrypted.c   | 38 ++++++---
 security/keys/trusted-keys/trusted_tpm1.c  | 90 +++++++++++++++++++---
 security/keys/trusted-keys/trusted_tpm2.c  |  9 +++
 8 files changed, 164 insertions(+), 23 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

