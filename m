Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F53547915A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Dec 2021 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhLQQWW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Dec 2021 11:22:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:51829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238238AbhLQQWW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Dec 2021 11:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639758142; x=1671294142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wNBGXF/gVIsUUSL+KA7+A18FBMlEr0hXyOuboGlwIto=;
  b=Tz7Cp+NK1RrBmbPL5PEOJFjQrBl38FwVKzUglYfAU/VyH5N7axP1rjQG
   t5YDZnDQU1gPmwoGR4XqpqcT8uf/uGSpgi1q526UgPw5GofDNEwjmubmn
   86Y+CchFyacZr7lMukFovXC/CMBvNwDIrnqYVCXSYNu+NY48pJfY03czS
   x+hlE9UIWfunUh4IsxS5VFW52B4pSDcOYQRLcuNaQFGbVDHL4uIfHjXYF
   PJY8/9+OjsThxV5+q+Ub1tmNFf6YqMmQyGXUdXJzfKDQJBQf8KvL8RRIq
   xGneSMXRoPIjL+2tRBDcjaT8rE1Jo9djWs5dr1yL4wohh6ihwBKzpbpkW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219796640"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219796640"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="756518301"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Dec 2021 08:22:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myFzu-0004v1-FF; Fri, 17 Dec 2021 16:22:18 +0000
Date:   Sat, 18 Dec 2021 00:21:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com
Subject: [RFC PATCH] securityfs: securityfs_dir_inode_operations can be static
Message-ID: <20211217162135.GA21682@93035147186e>
References: <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

security/inode.c:43:31: warning: symbol 'securityfs_dir_inode_operations' was not declared. Should it be static?
security/inode.c:48:31: warning: symbol 'securityfs_file_inode_operations' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index a0d9f086e3d54..ff720c6bedb0a 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -40,12 +40,12 @@ static int securityfs_permission(struct user_namespace *mnt_userns,
 	return err;
 }
 
-const struct inode_operations securityfs_dir_inode_operations = {
+static const struct inode_operations securityfs_dir_inode_operations = {
 	.permission	= securityfs_permission,
 	.lookup		= simple_lookup,
 };
 
-const struct inode_operations securityfs_file_inode_operations = {
+static const struct inode_operations securityfs_file_inode_operations = {
 	.permission	= securityfs_permission,
 };
 
