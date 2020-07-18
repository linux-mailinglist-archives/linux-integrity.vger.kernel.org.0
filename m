Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176F3224C7D
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jul 2020 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgGRPb6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 18 Jul 2020 11:31:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:55235 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRPb6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 18 Jul 2020 11:31:58 -0400
IronPort-SDR: 72w3EAyfQsRmaHB+AUKJ1JuLnDMamkAHige526ruYHvKusH8ozr8koxriR0f08SCoSResrGR9H
 R+d0ksErPOgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="148908892"
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="148908892"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 08:31:57 -0700
IronPort-SDR: gdhE7dCuJqRjzFN2bEbZolxZoUbvEF1XGVfS8VDh2PjAyMXsfwSrV7q0pKqf4fNOtO8HX2pr6S
 MtOPdl5pPEug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="327116775"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2020 08:31:55 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwooc-0000pA-MJ; Sat, 18 Jul 2020 15:31:54 +0000
Date:   Sat, 18 Jul 2020 23:31:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     kbuild-all@lists.01.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] LSM: security_read_selinux_policy() can be static
Message-ID: <20200718153136.GA11500@64f1e31015ef>
References: <20200717222819.26198-5-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717222819.26198-5-nramas@linux.microsoft.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 services.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 79a6b462f1fe9..4374c75f91a21 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3734,8 +3734,8 @@ static int security_read_policy_len(struct selinux_state *state, size_t *len)
  * @data: binary policy data
  * @len: length of data in bytes
  */
-int security_read_selinux_policy(struct selinux_state *state,
-				 void **data, size_t *len)
+static int security_read_selinux_policy(struct selinux_state *state,
+					void **data, size_t *len)
 {
 	struct policydb *policydb = &state->ss->policydb;
 	int rc;
