Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A38123CCD
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 03:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfLRCBq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 21:01:46 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38146 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbfLRCBq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 21:01:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CDFA28EE18E;
        Tue, 17 Dec 2019 18:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576634504;
        bh=T6tjpNiUMryOoxPh3ySPhu8SFS4EjI3JRGspCsj/mY8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r9SWdWgPZAriNlUwRheZsGDyXOg8N1lSFivMjwZvcs+ophIOapruPvRXsEhfmMfEN
         qRrH1AOGW67qWCDaoCu2AZBnv1IcjS6yhEjrafby6sDYBnZjsvVFVDyu3nDs81t1iO
         0YBwnvhYd9O4QvJW+y11boi+fVFl7OcJJIXQub/0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lww0zsdnfplq; Tue, 17 Dec 2019 18:01:44 -0800 (PST)
Received: from [172.20.1.149] (s138.GtokyoFL8.vectant.ne.jp [222.228.122.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1E998EE0DF;
        Tue, 17 Dec 2019 18:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576634504;
        bh=T6tjpNiUMryOoxPh3ySPhu8SFS4EjI3JRGspCsj/mY8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r9SWdWgPZAriNlUwRheZsGDyXOg8N1lSFivMjwZvcs+ophIOapruPvRXsEhfmMfEN
         qRrH1AOGW67qWCDaoCu2AZBnv1IcjS6yhEjrafby6sDYBnZjsvVFVDyu3nDs81t1iO
         0YBwnvhYd9O4QvJW+y11boi+fVFl7OcJJIXQub/0=
Message-ID: <1576634499.14900.10.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Wed, 18 Dec 2019 11:01:39 +0900
In-Reply-To: <152580f3-2a1f-fa33-cc25-f25747a470a5@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
         <1576257955.8504.20.camel@HansenPartnership.com>
         <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
         <1576423353.3343.3.camel@HansenPartnership.com>
         <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
         <1576479187.3784.1.camel@HansenPartnership.com>
         <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
         <1576531022.3365.6.camel@HansenPartnership.com>
         <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
         <f25b7299-1530-2e43-cdf4-2208c82fc768@linux.microsoft.com>
         <152580f3-2a1f-fa33-cc25-f25747a470a5@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-17 at 14:22 -0800, Lakshmi Ramasubramanian wrote:
> Hi James,
> 
> > > > 
> > > > This is the problem: in the race case you may still be adding
> > > > keys to
> > > > the queue after the other thread has processed it. Those keys
> > > > won't get
> > > > processed because the flag is now false in the post check so
> > > > the
> > > > current thread won't process them either.
> > > > 
> > > > James
> > > > 
> 
> Please let me know if you still think there is a race condition.
> 
> If yes, please explain how a key would be added to the queue after 
> ima_process_queued_keys() has processed queued keys.
> ima_process_keys flag will be true when queued keys have been
> processed.

This code is confusing me:

+       /*
+        * To avoid holding the mutex when processing queued keys,
+        * transfer the queued keys with the mutex held to a temp list,
+        * release the mutex, and then process the queued keys from
+        * the temp list.
+        *
+        * Since ima_process_keys is set to true, any new key will be
+        * processed immediately and not be queued.
+        */
+       INIT_LIST_HEAD(&temp_ima_keys);
+
+       mutex_lock(&ima_keys_mutex);
+
+       if (!ima_process_keys) {
+               ima_process_keys = true;
+
+               if (!list_empty(&ima_keys)) {
+                       list_for_each_entry_safe(entry, tmp, &ima_keys, list)
+                               list_move_tail(&entry->list, &temp_ima_keys);
+                       process = true;
+               }
+       }
+
+       mutex_unlock(&ima_keys_mutex);
+
+       if (!process)
+               return;
+
+       list_for_each_entry_safe(entry, tmp, &temp_ima_keys, list) {
+               process_buffer_measurement(entry->payload, entry->payload_len,
+                                          entry->keyring_name, KEY_CHECK, 0,
+                                          entry->keyring_name);
+               list_del(&entry->list);
+               ima_free_key_entry(entry);
+       }
+}
+

The direct implication of the comment and the lock dance with the
temporary list and the processed flag is that stuff can be added to the
ima_keys list after you drop the mutex.  Your explanation in the prior
couple of emails says that nothing can be added because the
ima_process_keys flag setting prevents it.  If the latter is true, you
can simply drop the lock after setting the flag and rely on ima_keys
not changing to run it through process_buffer_measurement without
needing any of the intermediate list or the processed flag.  If the
latter isn't true then any key added to ima_keys after the mutex is
dropped is never processed.

James

