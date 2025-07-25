Return-Path: <linux-integrity+bounces-6732-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B3B12016
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3E168CE0
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248D1FC0E2;
	Fri, 25 Jul 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JsQSovUt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E001C5D59
	for <linux-integrity@vger.kernel.org>; Fri, 25 Jul 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453623; cv=none; b=hoQ4CshlaT29JjesqeLgh//7zNVOd4W4DGMFdeNhhCVJHUKjvUyJ8xSDE5U5F7XBPlrXpt9hbf+0HhQfzXrXow4zsAXH3TsQHXpvNUbXW+I+7CTFZFANdafzm2XmUJUOTQ6AlazLIDImrFVEkHdZiNQdUZkfPqjCLLRxlmuHWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453623; c=relaxed/simple;
	bh=cEA30w3MpZL3oVw6hemJiFwo5KUjieqeDMilW37ds2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdjGgihE0GpEDdB9r9UXlHNtuInJlip+CmucHfCDbvGkWF0zGNksixmtJ4PitGfM0igEN+sqVloNoW7owI2M8Qg5ufThe+l2C7xDBXgy/hpn+/VF8pyLLA453TZiPOjiwhZfzcGkWNYrQjwrrzxQ90cHCmJPUNK4/iSlLzhB738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JsQSovUt; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753453620; bh=4L/07zDAQ1o8CpvQWX45Ah7M6zbPLNjU46ALanCiw4k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JsQSovUtVqEcU2yWYl0/spLuJJIPR71yEkTwBsNj3Q32be+rMrMq/FT1ztMhXQrn6jOv9nLhlqSwYRMKGEujL3umjIFgXqrW0mcAXsZ+BUUvFgSHeLmO/CjiMEvxRIfZxLPqUBaHJCU/7w+Ip5FFc+Pial1zwFVtZiTuBsq22l+NWNY3X3cGyyjYx5/lCLp1l2Qum5+AXEe0MTHb3VbZeZJxNGOftwDJrsEyr3pj3VSVQr33GGw4j5hHuWAbFPCLG2JaonxQpSijqjlAG6ovAK67B7ZsmfCgDWwkmxve45Y6zvF06YEn6QMOS2uscu57WLzA+aoRm+4ia0Vtd67toA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753453620; bh=Vrp2qLwN9BpzJFp67JepxWQbVUniti1OXQhmHrV7Zq8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iJL1p0WpRt3tuLm1ml8djPcYHHevyMzgvfrMC1WBd+wrag/kHXuKNR13JaIfyPmLxbiYFKbouNSTF1yJJD/DYsInb0MbBaX+MihXLNTby5UR/ao/VQ5dKsfIOelCzHd4pinIi8JGOZhVwtkUK+tpvOw1mSFzjas83HMSgLt+azz+KGA0ObLQLLCxUAA4DPY9megjT32WDmssRsr38ppf5eRzEBGtgz2nbHjJup+/bkvnl7B4sYI/eONtjqli6xkCaij1yrWQBB+FA7U5B1FvbMYgCnno0J9j/xG4ojPxddoOJ6Nhbr2HkV5kgXPDFbrZ71Ira8+qoUUQF78ifdbpZA==
X-YMail-OSG: s2mSu2MVM1lyYOsANwxGprcd.Dq.iQ4KFR8v0q2tU8zhgGEONC.Y742kFBx0tgi
 CGNCdhDjbFhnMXNCojP1F8BAG4OHzcu_KjFmQ9VdfrhTpK7QGv5uo3YzDlp4Y4LiawqXB1y1Xir_
 .s92yOsg1.16Xrl9EcTFG8YdnQueeVTRV2RF7L6y.F.oJlhRNGGDiDoTIXWqlYkBmV8.fn.8oEtG
 bj4NWjYf5dwm71L6lMXVqaiiI8pITbthHYNVOWAIKNn27lLNMeldXWmELXnKpJl2iR5_qV_cKjSs
 LXU3PqxHt10nM4f1In1a..Qt1JC4OCQ92fkznoIihyi7w25C18ojSJXFqO.fUjDPJ9ednBPxGVhU
 yPZcRwvWAJFeqgqA8GRS2U7RrT2dWCnkevz3X.OL9VRzi1bsaRZe7.TxiNnfkeWMPj2HP_Q.sdsf
 NCcZtXQh01_X4h76dlYMalUJdbdJs.7TS3xhk2jgy7k0Pn7UF82hiwam_rxr0lYUSMf8TYqEpWVN
 lSXsQq1D5Z6k2KHyUobiEVlJ_UZXNFMNL.tL4iwTg41V5_ucvry8xTQITkqLRdwtbSdoEmcOfzyF
 JJbcS_TACuzP0vas3VQr7rlchO3YiTDG40.Qi9VOkdGRPvEZbMd_Q7cW8LS5Xw9xZvtm5J0an0ra
 wuIjRGDxDA0.Q47EyXMc1qcBNFqwfrM9P9Y7_oltrzFAsTVIvg4cmTwvPTeK51koZcfV8kwwTadl
 c98L58gBHn4Xtk_E_MOLqj1kKnNihfMM6EffnZ20kT8wVigQhlkjHsLv4Kar4GNUY1BasgCa82.O
 70XduxoxAPlu_7smTUFcRnVytPkaWmqN5vkaRmYB6DZGiXfGt.x45EuqZA8YiGjSeznqoUgo3f21
 4u3EFUizgALHZiCLWwzj1BYdNAtvo05RXFh3kWYmOMUD1M5yMhm2NJ9WvxwczeyXnsgmTbN6xlQe
 l24bJwxCqlFibOvvkhbloDG1CXkyLrPD94qEuPW2w1ldi5_L4BXgx0vqm49P5Sar1eZRyTt3c0yI
 9d8oeOqpp7COEek6EejWw2BAaQ7xMlHkdpa67o5jE04gm6Oxt22TUAJwJLdlMxvPLX4b5MuVtoyi
 HI5ir6HNUA2RnnI8KyfZj5BfM1DdKagbFb_2ieR9b2XOqm9E38mLXoiZqVvLOsJcd88g2BsNmg27
 5O11y5LWqpm3vFvNxMWrmAEQsYf5H5jVvMwcrg0TXKw.3.onQ4xFsJV_q9mLjkG9XNx3VBz5rbNj
 RA6LhkPAnQ.7iGhotqRRZYeDbOU19YE6teYM2Dkf19JT0uXJcGhK8jfkwhWTrfdymlj_Dg1NiUjV
 WvI0MxWVLnDygW08i2ZwzcxSRZgB2hBGiq377x9Vl5vk0djz0S1Rbzhsheqzragj1rga7SiuJ6Zz
 xnGIZvTUO01RS09FtCwTFV2_TjpTHK7whClWT_J772HVtxO2Tb2O4HygUCR6CrQ2LS054mlMPi_a
 zcTR83SpAkeWIlbN3L.nCEorQrFNcsduOliLQv3Fxl6hGXw9Bsp5xDlz8TIBAuRO8Ry9WyDUHcqG
 .FuKQhNUyYZwsaNBri3tAD9yoTp0jePRiXuLFKzvWu4sY_Gu2GI9MCzlIHVo_KaWyVC.BkpT3wKw
 A5ZPNMrUovgamqDyTH0fjaNFfm6QAV.w0GCCEEBIaETaOCavT2y1TFLxEdMiABN23dU6yb39bmVa
 Iibkpe0xHQvq9jPyu4h8b2ntQQzrz.525n4oxeBGxamF9w7MLvfenIqkT_FzrpSLObKlHw4XH71L
 5RV8ec736ORlIVXL.ekuSJTV.4QbZ6zi.3k453giv30IJdHapuwwiiapIOh9YoPXL5M3.Qz6f8bb
 UPi91ScvepJ3v8rGo40MpHexD5UxAJtSvzLTuc59fUeLtQU3CY9iApCpniSzYNgGNcJrEzz5ch7y
 VqkIC8CLdZczi.8hmUryoaqiKbK577aCVUtkZLrJ1ql_AQsbWf_Y4s5bgyHUDOMGlDt.mvtFJf_a
 ecCtTVn.yWruCd824.5hrP0B_SmdmeWqxw2gZyV9pleZEdJssfeeWd_HC981Pr_IVByKJwxpIlDy
 m88VSLqdkQAN8oSmnPSoFh8MEwKeARLtukZTYi0289AlT26FLw83l.uAqXNZ58hWQ6tfWg_6PzVt
 OO9krwYnQBcVPWyPs98JnOd_ZkSKPeuASNg8jE2ld7jpn9oe74oGRPUrzt6mMMuZUp8VuSHcNmJ1
 LBa5DkHkqKr.4W4IK5.SWQ9OWgiX7_O5vmVKWVRzIuEcZ69VdD5ic6mcY5oMUJry1T4jnF5HeC_k
 dLqLKzsCkCE1GfFYqOjaQll7oERU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b74aaf0b-60ce-4d2a-9411-b67a14d98786
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Jul 2025 14:27:00 +0000
Received: by hermes--production-gq1-74d64bb7d7-6nlps (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fd74b3b9ff657adf672eb7a246ca7d9d;
          Fri, 25 Jul 2025 14:26:57 +0000 (UTC)
Message-ID: <6621fbb0-fb66-4aa0-b77b-1cd0db195660@schaufler-ca.com>
Date: Fri, 25 Jul 2025 07:26:55 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/34] lsm: get rid of the lsm_names list and do
 some cleanup
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-47-paul@paul-moore.com>
 <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com>
 <CAHC9VhThNtGCA-jmjRagJfzPJaTh9myqFcwqA4J5Zv3ojEFDfQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhThNtGCA-jmjRagJfzPJaTh9myqFcwqA4J5Zv3ojEFDfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/24/2025 7:28 PM, Paul Moore wrote:
> On Thu, Jul 24, 2025 at 11:39 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 7/21/2025 4:21 PM, Paul Moore wrote:
>>> The LSM currently has a lot of code to maintain a list of the currently
>>> active LSMs in a human readable string, with the only user being the
>>> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
>>> generate the string on first use and then cache it for subsequent use.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>  include/linux/lsm_hooks.h |  1 -
>>>  security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
>>>  security/lsm_init.c       | 49 --------------------------------
>>>  3 files changed, 57 insertions(+), 52 deletions(-)
> ..
>
>>> +/* NOTE: we never free the string below once it is set. */
>>> +static DEFINE_SPINLOCK(lsm_read_lock);
>>> +static char *lsm_read_str = NULL;
>>> +static ssize_t lsm_read_len = 0;
>>> +
>>>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>>>                       loff_t *ppos)
>>>  {
>>> -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
>>> -             strlen(lsm_names));
>>> +     int i;
>>> +     char *str;
>>> +     ssize_t len;
>>> +
>>> +restart:
>>> +
>>> +     rcu_read_lock();
>>> +     if (!lsm_read_str) {
>>> +             /* we need to generate the string and try again */
>>> +             rcu_read_unlock();
>>> +             goto generate_string;
>>> +     }
>>> +     len = simple_read_from_buffer(buf, count, ppos,
>>> +                                   rcu_dereference(lsm_read_str),
>>> +                                   lsm_read_len);
>>> +     rcu_read_unlock();
>>> +     return len;
>>> +
>>> +generate_string:
>>> +
>>> +     for (i = 0; i < lsm_active_cnt; i++)
>>> +             /* the '+ 1' accounts for either a comma or a NUL */
>>> +             len += strlen(lsm_idlist[i]->name) + 1;
>>> +
>>> +     str = kmalloc(len, GFP_KERNEL);
>>> +     if (!str)
>>> +             return -ENOMEM;
>>> +     str[0] = '\0';
>>> +
>>> +     for (i = 0; i < lsm_active_cnt; i++) {
>>> +             if (i > 0)
>>> +                     strcat(str, ",");
>>> +             strcat(str, lsm_idlist[i]->name);
>>> +     }
>>> +
>>> +     spin_lock(&lsm_read_lock);
>>> +     if (lsm_read_str) {
>>> +             /* we raced and lost */
>>> +             spin_unlock(&lsm_read_lock);
>>> +             kfree(str);
>>> +             goto restart;
>>> +     }
>>> +     lsm_read_str = str;
>>> +     lsm_read_len = len;
>> You're going to get a nul byte at the end of the string because
>> you accounted for the ',' above, but there isn't one at the end
>> of the string.
> I'm not sure I understand your concern here, can you phrase it differently?

"lockdown,capability,...,evm\0" You get the '\0' because you always expect
a trailing ','. On the last element there is no ',' but the length is added
as if there is.

+	lsm_read_len = len - 1;

will fix the problem.

>
> If you're worried about lsm_read_str potentially not being terminated
> with a NUL byte, the strcat() should copy over the trailing NUL.
>
>>> +     spin_unlock(&lsm_read_lock);
>>> +
>>> +     goto restart;
>>>  }

