Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B793460DC
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhCWOCM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 10:02:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62464 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhCWOB6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 10:01:58 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12NE1XC5092848;
        Tue, 23 Mar 2021 23:01:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 23 Mar 2021 23:01:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12NE1XaB092844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 Mar 2021 23:01:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
 <20210319200358.22816-2-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
 <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
 <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
 <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
 <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
Message-ID: <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
Date:   Tue, 23 Mar 2021 23:01:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021/03/23 22:37, Tetsuo Handa wrote:
> On 2021/03/23 21:09, Mimi Zohar wrote:
>> Please take a look at the newer version of this patch.   Do you want to
>> add any tags?
> 
> Oh, I didn't know that you already posted the newer version.
> 
>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>> index 1d20003243c3..0ba01847e836 100644
>> --- a/security/integrity/iint.c
>> +++ b/security/integrity/iint.c
>> @@ -98,6 +98,14 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>>  	struct rb_node *node, *parent = NULL;
>>  	struct integrity_iint_cache *iint, *test_iint;
>>  
>> +	/*
>> +	 * The integrity's "iint_cache" is initialized at security_init(),
>> +	 * unless it is not included in the ordered list of LSMs enabled
>> +	 * on the boot command line.
>> +	 */
>> +	if (!iint_cache)
>> +		panic("%s: lsm=integrity required.\n", __func__);
>> +
> 
> This looks strange. If "lsm=" parameter must include "integrity",
> it implies that nobody is allowed to disable "integrity" at boot.
> Then, why not unconditionally call integrity_iintcache_init() by
> not counting on DEFINE_LSM(integrity) declaration?

Or, I think below one is also possible.

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1d20003243c3..37afc5168891 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
+#include <linux/sched/mm.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
@@ -85,6 +86,20 @@ static void iint_free(struct integrity_iint_cache *iint)
 	kmem_cache_free(iint_cache, iint);
 }
 
+static void init_once(void *foo)
+{
+	struct integrity_iint_cache *iint = foo;
+
+	memset(iint, 0, sizeof(*iint));
+	iint->ima_file_status = INTEGRITY_UNKNOWN;
+	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
+	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
+	iint->ima_read_status = INTEGRITY_UNKNOWN;
+	iint->ima_creds_status = INTEGRITY_UNKNOWN;
+	iint->evm_status = INTEGRITY_UNKNOWN;
+	mutex_init(&iint->mutex);
+}
+
 /**
  * integrity_inode_get - find or allocate an iint associated with an inode
  * @inode: pointer to the inode
@@ -102,6 +117,18 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (iint)
 		return iint;
 
+	if (!iint_cache) {
+		static DEFINE_MUTEX(lock);
+		unsigned int flags = memalloc_nofs_save();
+
+		mutex_lock(&lock);
+		if (!iint_cache)
+			iint_cache = kmem_cache_create("iint_cache",
+						       sizeof(struct integrity_iint_cache),
+						       0, SLAB_PANIC, init_once);
+		mutex_unlock(&lock);
+		memalloc_nofs_restore(flags);
+	}
 	iint = kmem_cache_alloc(iint_cache, GFP_NOFS);
 	if (!iint)
 		return NULL;
@@ -150,25 +177,8 @@ void integrity_inode_free(struct inode *inode)
 	iint_free(iint);
 }
 
-static void init_once(void *foo)
-{
-	struct integrity_iint_cache *iint = foo;
-
-	memset(iint, 0, sizeof(*iint));
-	iint->ima_file_status = INTEGRITY_UNKNOWN;
-	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
-	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_read_status = INTEGRITY_UNKNOWN;
-	iint->ima_creds_status = INTEGRITY_UNKNOWN;
-	iint->evm_status = INTEGRITY_UNKNOWN;
-	mutex_init(&iint->mutex);
-}
-
 static int __init integrity_iintcache_init(void)
 {
-	iint_cache =
-	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
-			      0, SLAB_PANIC, init_once);
 	return 0;
 }
 DEFINE_LSM(integrity) = {
