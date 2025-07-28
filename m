Return-Path: <linux-integrity+bounces-6745-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E5B14510
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jul 2025 01:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F161684CF
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 23:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118BD1FECCD;
	Mon, 28 Jul 2025 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FMNTxzEX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic.asd.mail.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAA222597
	for <linux-integrity@vger.kernel.org>; Mon, 28 Jul 2025 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746994; cv=none; b=QNsCTws+WaOF0VE17Oip+H+r4khsNKtKBZtqlbH+wrpIby7ZtgC1CZNIrT2NXLsYa2JIgLD3zoyjFCbKMbaqRU/IJtyuCriqqZW180NBCBalVe6i424uZXNQHv8+zDdkGpLwJH2GyPlF5y41T05o8jkDn3ZxiLhmc2ybi6V1BAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746994; c=relaxed/simple;
	bh=7k/zOCzrkgcWHk6+aFt8QI3jICkkF2jDPt3Xd9tYJ8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amOwklUD8vx4uoWc9To9LvziagtY2HGOtDsMZX5yTe0BYoBCahlydohl1ic5HMjn76nlQJz4b5twIZ39eH6r6XsTSj/ValYpAhySiA+NzHalK/Ktjnk/8CmQhqRz2oyD8aNA+I+h75P67+bNmW8k9isU1SOxb1VOFxpdCSsAID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FMNTxzEX; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753746984; bh=kD4BURVA3VF9L4aFm7PiFdBV+6tvAOoJ000UeHPh0eE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FMNTxzEXC6Au90qUORyBaAbtQ4sVfYITLmMMTSabwfO+nh5AWVxkxFwW279TjpAZqmL5tJFZv7uDUyRo2hGpisc3wL9X1MvPI1FjKvbfxADDOUGrv0hy5Be6SWzOelsYqwWywUy4ooNdKVgqjZhrs64bYVcYZ5grfpVChaBjr+I7PeW5LKpSBIPvVP0trmOPO7GS2JZg2RaBv+st5RxSZs5kCzvEJPkmAJ7DrwMb2QHG1jkBwci2fivvu6oGwDmAVu4sJtrx8M0QMSf53EnOzggYlEHff6SYMXHOzeIEkul+8UkAfKvLZ8r14ioZi0RZrPoChHK7QJq7/b6AO4Br2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753746984; bh=bpgJ8a8tiTI8QOFr0mpRwhvuXWls7t8e51TyuXoSozs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=m/UznAaZopiAZhTMpevEcL82PaX5uZMsf8bOwZWWOdAVr1G+89y/QPqBwLOyiIxzMZwnakw6sgUtjpq7j1m/UPfVTmh2X9u3QCVXEEi+d9xINiPmxP4mcc7hG0auwqjfNwTvttj/I6W1hyecUhIDEVrjfjWmDUQs9zoHrBzIUfwu1N0A6rwXA8I0TUjLv38sB3pq4eExQcKE2XvwY6/2HVzubIcWpjEJOM7rmSpvXoVWVITPu0CGPZbxSIqXljTdzOOF7CV3+5tAr0gHOkCnQ1NNODO4oe0l80IVw0ZmnAtgOPGDspbEKq93U5f8JiUrUeSFqjOPYb+4r5ieuyvcug==
X-YMail-OSG: xgdhF9EVM1kTtrViOuhlfyyQpTF8s3E3kl9ooRHtOS8ByYmeGIyWSV0wEoY26bN
 rgbSV6tA5i4wqIDr5zlnjOpsSwzCDidH7VdHBDmgdm2DD2CNVFyxgDZVKMrokYJKGxkuP6uw4By2
 chmK1Gy0fReH.Ug1ZGLswBek.61Ezu2jswkeTkGtQTj_XbVTdHP6iA5uGP7E.JmKmiUYg6qhQPOF
 b9IBsZAiw_A7Upjz5IxnZJHB0EJ0KdxtzSTM6h_fddKPM__KOfvzrY_bpX06ae_CtCsuMwCGl4gI
 gozL.x5icByihADEj3VVDKFz12nqyfL0hA4sJf0Yi.uxJK4.rxmsqG_VJDLi4w4WYViY3gC1or.H
 aWbAC3.6qfuMJlTcmyL3lAxw5ozInMaucLdbNzUpMALSYwnL2qtYuLiqRhIBHsTJEGaa4WjNYM_N
 HMeV1kvTbsiTDab8_P55kjhjYNXgadEzidMSaHLN9L890laCfUn05nIevcPzbH32GH7v3Sf37HQ3
 l4C9ACX6AJWup.gJPzecHgwppoaOkkOFMLpA_FkNrO6nMp6Qo7e1A0jgXOf.glGcR03kWPVPBCT9
 dEdLxNoZUphLP0QGgD9YTCyqS8OKhv7UxHRxJ3lRpsXfrQh5mwH_gH.IxwCtKEwaHDS89n8Aree6
 jxhuVI6PVp97CiaB5resl4rdOUBNonJPcnHLBEn5_jfPQlmKsA1arwEsHn2o4PfZQd7TKYpK6ygG
 BhXbOtn8JnDMecXq7Tp1ViqUHQRbADbqC_grfMQpkAmijYuo.lvfLL4C.7J69j66XgrMsnp5Rnbj
 C0yFJFcROwGg47iqpFgJ6_FSZIB12UF5EVX8AeyvPqJxTfHqeAxFKy28gBwMr9gGEtW5FogSlwhz
 4VXKwZWkdUtMQs9EZ0N2bxM3HMif2evlEII5i6PhxR4qbQgS5UMYhKSMV8M0Zwv1U2mXqoZwaFO3
 kiZm5MFw2lJw9_1umY416j4w08NdVZAPOxDr8Zo4rjoaBaRoU9AiabUdIX8iHFYSxeWK2UbqfVUY
 PFvl89pZYy5ArF02vg5IR8uaik5y1NUr686gtV_v2biRYjp.caxBX0sHkKF4oXMVeaFQBu3TGshE
 r.QjDgPHfYwnHT6j52Gg.DQbeB24nPL.UjE4QGWcuysxDF9X_Of8GDNOzk49_jkJqhv86lnexiRA
 brjjJueFXqOiTHBooJ7NFe1lXRqzhmhfmre.tjw9uSVLoW9L9G.lcChQpWjptHUFMqL.KOMGiL0C
 WL6o2uJ599dlLt.hVC08NrE_iF4L0V.osC_SqVtRwhlQcHT1qa3qTfmoycNT8aZFI7nq2ba21CAX
 0tJwhKTZ6rCpoVzuzAQU.18yqvuw0wJ8SDGQMISvxErFn_kWwcZtiXqpjgcOFDqYQe6nty0b8s.1
 88wCKEHBFDt7INYRtRLAmisKkrxxaNTwyZqN5mKhFX3eKkghMFWpXXMMhj0oZ2kt6HVtiDEZ.pFu
 V6PooIFD7ejAlB6uSW_O0qcIU7NAwxAX1ZwinOaMkbq6eVkXvPNeh.nnRkutolgxEr8DBKA2oC84
 dCI9Ajj2G.D6FX2fd6vIyYVuGUKpcej.kWXcO50igub915KccMkkFBakddQ_WTAn5n85OiRzUKFN
 sow0aJQgx_0jHM41o4VbaXTRoW2Kr.gNGbQ9Y1NjhFJfMlLWrvnFQ8VGERZNJSIFcL_v0JXZFW_R
 yxDI7h2geridmCDodrrAP0iyhiLmSor09dNXR_eJTVwt3lawMLMIa5maT34m8qsfVXqGb5SBL40Z
 3g6huJD.Nc2Dr6oMJTC1oxiDPrO1wwD5H2ByDpmftC4ovKYc4nN9jIugJ5ljhlFh4Ffij_aqAw1g
 _Iuev42Le6iYXbJv2ulqk2mSns2MIks_nwh1ZM3s_mWn_xzk.O9Yioa_RPdjZabdd1uAX.z8XVJQ
 ma1AF_GKUxYm2w8vpE79stD5LI1s9UsrS.dyUqy7NjM04wUi2MYkMAhGSDtKOBpCSMbpfzyoxe2r
 gJ_P_E0oSbGkGn8vQr3hE8h9Jwa3KAMNPW.q8k0erJncSDQE7SVdVsvg..nLD97Wddboqq_.Kl1V
 EieOzt1y_ZS8QOqOFNZzLm.rzDOmmUMNXNN4mkef50Bkpfyoa4b7JF.M_IacogEWWLcV9VRG7Gj.
 zPVbVXQKSX1pw3_TuGkf.hXmPUnggU6a.i3gcAdoupU.1N3n9bIBobymSwDvasaat0Ie45nDn9ld
 dK1QPkfUb8o6zcnYfRIJvw6DYn7dgDjkbhECCBhd4hrif8QTdxPMMPQ.Oi6A9ReRqN7L3Hvwc5Ki
 g5vU_YxYAkGdbw_JUqPkSIl0jKJ.I
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 46dee01a-f54f-4f4d-aad8-be352304a25d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Jul 2025 23:56:24 +0000
Received: by hermes--production-gq1-74d64bb7d7-nccgl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c35aba859699e7e63b8e78e746f6c9b0;
          Mon, 28 Jul 2025 23:56:22 +0000 (UTC)
Message-ID: <20053d8e-74e5-42a2-b829-e2b92007cf73@schaufler-ca.com>
Date: Mon, 28 Jul 2025 16:56:20 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 26/34] smack: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
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
 <20250721232142.77224-62-paul@paul-moore.com>
 <5ff016adea8969e4a97387d4ed88a172bdc4b3de.camel@huaweicloud.com>
 <CAHC9VhTh1=Qh2_4YKsXyC8dT6BFyh3nVbhfexLFsAWh7wiUCjg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTh1=Qh2_4YKsXyC8dT6BFyh3nVbhfexLFsAWh7wiUCjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/28/2025 3:34 PM, Paul Moore wrote:
> On Mon, Jul 28, 2025 at 5:46 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>> On Mon, 2025-07-21 at 19:21 -0400, Paul Moore wrote:
>>> As the LSM framework only supports one LSM initcall callback for each
>>> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
>>> wrapped with a new function, smack_initcall() that is registered with
>>> the LSM framework.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>  security/smack/smack.h           | 7 +++++++
>>>  security/smack/smack_lsm.c       | 9 +++++++++
>>>  security/smack/smack_netfilter.c | 4 +---
>>>  security/smack/smackfs.c         | 4 +---
>>>  4 files changed, 18 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>>> index bf6a6ed3946c..885a2f2929fd 100644
>>> --- a/security/smack/smack.h
>>> +++ b/security/smack/smack.h
>>> @@ -275,6 +275,13 @@ struct smk_audit_info {
>>>  #endif
>>>  };
>>>
>>> +/*
>>> + * Initialization
>>> + */
>>> +int init_smk_fs(void);
>>> +int smack_nf_ip_init(void);
>> I made the following changes (due to not having
>> CONFIG_SECURITY_SMACK_NETFILTER) ...
> Nice catch, thanks Roberto!
>
> I made a slight change to use the defined(SMACK_NETFILTER) macro as
> done elsewhere in the Smack code, but otherwise it looks good to me.
> Casey, are you okay with this?

Sure. 

>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 885a2f2929fd..3662d61bb32e 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -278,8 +278,15 @@ struct smk_audit_info {
> /*
>  * Initialization
>  */
> -int init_smk_fs(void);
> +#if defined(CONFIG_SECURITY_SMACK_NETFILTER)
> int smack_nf_ip_init(void);
> +#else
> +static inline int smack_nf_ip_init(void);
> +{
> +       return 0;
> +}
> +#endif
> +int init_smk_fs(void);
> int smack_initcall(void);
>

