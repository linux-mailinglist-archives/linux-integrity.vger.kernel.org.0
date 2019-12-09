Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D011788B
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 22:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLIVea (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 16:34:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:18340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfLIVea (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 16:34:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 13:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="224929832"
Received: from tstruk-mobl1.jf.intel.com (HELO [10.7.196.67]) ([10.7.196.67])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2019 13:34:29 -0800
Subject: Re: [PROBLEM]: WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Will Deacon <will@kernel.org>
Cc:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
 <20191209202552.GK19243@linux.intel.com>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Autocrypt: addr=tadeusz.struk@intel.com; keydata=
 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
Message-ID: <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
Date:   Mon, 9 Dec 2019 13:34:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209202552.GK19243@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/9/19 12:25 PM, Jarkko Sakkinen wrote:
> On Mon, Dec 09, 2019 at 10:34:32AM +0000, Will Deacon wrote:
>> Hi,
>>
>> [expanding cc list]
>>
>> On Sat, Dec 07, 2019 at 11:04:20PM +0530, Jeffrin Jose wrote:
>>> i got the following  output related from typical dmesg output from 5.4.1 kernel
>>
>> Was this during boot or during some other operation?
>>
>>> ================================================
>>> WARNING: lock held when returning to user space!
>>> 5.4.1 #16 Tainted: G            E    
>>> ------------------------------------------------
>>> tpm2-abrmd/691 is leaving the kernel with locks still held!
>>> 2 locks held by tpm2-abrmd/691:
>>>  #0: ffff8881ee784ba8 (&chip->ops_sem){.+.+}, at: tpm_try_get_ops+0x2b/0xc0 [tpm]
>>>  #1: ffff8881ee784d88 (&chip->tpm_mutex){+.+.}, at: tpm_try_get_ops+0x57/0xc0 [tpm]
>>
>> Can you reproduce this failure on v5.5-rc1?
> 
> Does this appear after variable amount of time or detemitically always
> at certain point of time (e.g. when the daemon starts or perhaps always
> when doing a certain operations with TSS)?
> 
> Do we have possibility to get the user code path that gets executed when
> this happens?

I think that's expected for a non-blocking operation.
To get rid of the warning it should be changed to something like this:

diff --git a/drivers/char/tpm/tpm-dev-common.c
b/drivers/char/tpm/tpm-dev-common.c
index 2ec47a69a2a6..47f1c0c5c8de 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -61,6 +61,12 @@ static void tpm_dev_async_work(struct work_struct *work)

 	mutex_lock(&priv->buffer_mutex);
 	priv->command_enqueued = false;
+	ret = tpm_try_get_ops(priv->chip);
+	if (ret) {
+		priv->response_length = ret;
+		goto out;
+	}
+
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
 	tpm_put_ops(priv->chip);
@@ -68,6 +74,7 @@ static void tpm_dev_async_work(struct work_struct *work)
 		priv->response_length = ret;
 		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
 	}
+out:
 	mutex_unlock(&priv->buffer_mutex);
 	wake_up_interruptible(&priv->async_wait);
 }
@@ -205,6 +212,7 @@ ssize_t tpm_common_write(struct file *file, const
char __user *buf,
 		priv->command_enqueued = true;
 		queue_work(tpm_dev_wq, &priv->async_work);
 		mutex_unlock(&priv->buffer_mutex);
+		tpm_put_ops(priv->chip);
 		return size;
 	}



-- 
Tadeusz
