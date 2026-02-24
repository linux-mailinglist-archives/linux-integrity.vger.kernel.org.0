Return-Path: <linux-integrity+bounces-8550-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O6mBJjunWncSgQAu9opvQ
	(envelope-from <linux-integrity+bounces-8550-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 19:31:52 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66618B6A7
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 381D6301440D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318729BD95;
	Tue, 24 Feb 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o4zYrUCu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DB28A1E6
	for <linux-integrity@vger.kernel.org>; Tue, 24 Feb 2026 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957908; cv=none; b=uUfWHdPYsbjweiO1Tw+wHpX8aZcZFmx+F3l7GbdoJvkiADmrR9tI5T27hyRyuQbfPkdiHIc/y+wcB5D5xJi+LPU2Gk7YI0QlxFFr7fV+m6jqwv5UcuimeHWFoqF9qV6X2BXARZIT96YggRiVgfSKRMIkeB6JqcnOivueFPbK51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957908; c=relaxed/simple;
	bh=tHqO38mclNDHgKmErN6AOKgzGd8ZLgfsUQTIhn7+/B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCco99qpwtkbzv9aaORrBJeQecj+x8Jp/lKRsql25UIFAx5jNzWda9PzPB3Re5YBKWQmnEOMXZ8hnv08Es52UOAR0cdFZ1tTQP14Y04hewJq91SNdfXM27fel15Kuiv/GJMX2pYF9PiqNSgSE2p0Id29QE8WsPpO+ejvqRhk7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o4zYrUCu; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771957900; bh=WaEhfhlC+YLyS63jwcPikkHdTx/qWoNdCwif7OiK3sI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=o4zYrUCuQutiYFt9/rgJW4zCW5BYrWqXnyyGc2qV3rgy6ZJsDicCSX8QKNl53W7eIHizKo3IBouPq2fUSbKXD7V1kJfSjVFZ2aH3t1g28dYza53t7ZnqpuW+Tvk9rUO3Cgi4ofypoVNqROT/Jd7CA8WxiBar+K6fQ399phos5NxNWeP/CO7Id8iSZuYEiRP7l2N0dg5G9D9izBaYbSgiPbdRXe4sQgV0XhBAvtJcB8Ta4jEA9VfjK2JpAiRsHC0nTJWufw2Hnbs8kz1JuKBNN0ly5WRcc0b8fIURRsZ+PsqsrUUP899CEEoRXkvgPfohJC9kX9LZAui/UuAHlEddgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771957900; bh=fS631pziZ0sYnWFjIagZaohlHeIkKBzc1nLDaQaTJoA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hjnQDhKPd41BnrfJZBmAf1AgXxdS4XyNDejvURC8SMsCiirx15JTEFVXhypYvjZq7NHAb2PndruXCANUv7E5/h5Nm9d6k2Dfx5+q81dwKe2owNmgy0slujSTcOjnlh9XnO/AHrejW0hM7pXCiKt/tT3XZzVcS9cgP9sVzeYKmGRdisBkBQj63GLVPm9XhIgZEkewHPUjgJnOLawuyqdgo8V9QEUFt9VfU0nnPVIED6nUAksoH1ii/d/Fug6dXJE+XceD+wTn/plg5XBIPCqAoBrRJqZodz8VjV7hsA8L0GoNrMfeuZY7NRgTnBh0IZtvx/svtG9KAoLuwrjm5uRWSg==
X-YMail-OSG: o1aE7fcVM1kzBUgU0EdgJQUTLPcDYOMbFa4GCIfjvvSNIItrdJ_zOMPvmmDd64b
 Vnxfywgs3grOkRH2qStYWb7v8v.sOnodEUa_zV9rj5YBsgm1NbLS89bolTjuqOH_aOVsMIWP5FuW
 eQzLuRIyKPlrKuV7IweUO.wkTpT1uvJxxD8mvAyRl3jVaDoHJfl3f0m8Xyu4CYeUb5fVUJq6ksq7
 68WKewIqBZO7KvVhTPYSM0ZGfVMm1VutffObomM5ozcfsbelYkXou4GaYdLT05reM.mOl5WwdU.q
 rY5yODnK4Mq6vRKn5Mb0bj20rnaArJv9tqzy_7hev0C6X9Dmq6ihGwNyPtx341dJr1FLV5S7b.UJ
 dfEfGKuEECTbvACxZ_LfUGvTAsoOOeLhd5VbOc6QDoSZXbCjYC20RQ_zXOTbyuIgBeJwLcm41BYy
 ux8Id6q.HjZwrOS1r60lMOZa6FCZe_rim1glUu8W_o_YwALGVrxD1TipLd5.1WOe.mdEvJ7b17r4
 HSYcoYZr7r7pOb2p17b3nnZSioH_9d4m8lm8u4ZHc3wH3rnebfjfVrGDtD70PMe7DAQOZIaWeCRX
 0e4kUhR2tuPmX9YheiWd6wt3_UjZF6n3I7VUVmYE2aO0gMUh_.wcCtKWKI6W8Q6qJSNf9V2t5LtJ
 gf2ghewjNMdMh.gA06lVZhrU2Dm27xrNzX5CwdvOn_QrJyFEVtdfXRqSWvkeaiLGw5UUTrxhflEu
 OiLqKCsCOyAhm3jxaTgA06XDgqf0eqV6EhQ_h1LdnLaYUBW3XVp69Yl7uR6RJTj7OY3vDDq4CFGj
 OOOUfvrv.0iDlp2_2shPKzYzuIm1rM9i9F76hD.S346TiuBwoaaiUKAVOlGMlHrPDpSlb_iH4nR7
 k34OEEvh1dkiR.GqJQI26OWlhSGKo2sODU5xwc8Vh1ZXg80By68_uuUSTbAcDI52dRY6Mgtr1L3J
 vSi.42a72GD.xqt60_FfigV_YMTqPTHcwP73wd_fAjqr24G_uU7ZDSd.WXv6TeTmRzzOfoMTAp3R
 hznGu_VzHAf00Yha0_q4s3jSuPL0H7st3R_Zc9GZ5bdZwIMxP8RTkool0WoiqaT7uim7reMTaU_6
 _v_LmGd6oQC__84IgLAaD3Q9T1ALeVKz1Z_0BGuYghcdprs5aUn9SSyH6W4KuPDm77rO8PvNvzYV
 GjgXBHky4sIkUnWXbqYDXelYMdMvo34vcvepWfuozzya43x4hM1R6wxZ1a1tXxe.mE4cIB74Keqr
 6c.RSM8ACC.lQ6b8.8DIk7woRgu0hM6FoedXWGg99rkEIzlaABck0d3fc11.9PzEh.wf6bJ5JC2d
 wZz8UE_5c1i5PfONzvnMWkkile7DD24m._ghHvwZA5yAZbn1RNL8To9wxtf25ExWm3neMbqF8h6s
 vOnNEkxHgKyHH19HtTOpkKJq.04UvCCpJtImfkAYX5uBRq03N8FoIVb91FAJsf_eCwTToOJkUw_L
 5D0wfVFBqJpGpPee3CVRpdgzpUd7wTuy6SmPd9XYlX_7YUcWkgj28tN25oeUtrhWR80ZRUvO4raf
 QvMrnGPbNBzsUtR6XzwXbqOMgDNUTHexFcfdcWEoWtut88YuSmUkRqx.2Way5kZSX04I10LdV2Qx
 ijWNLVEiv5xt05DePq.H4gUPqqaxQmV2JRgPSs5WGBllvDmm83_.suPSUWDbOUguqZxrXpn8l3IU
 SKkdRFFdJ98JHo.9LZGpDeZVE.cR4JxhvlcbI389TzHftTEFz
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 86232e4d-228a-4d05-bbea-91a52606ac22
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Feb 2026 18:31:40 +0000
Received: by hermes--production-gq1-6dfcf9f8b-xs62w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 28346b8124a6cca8105105787af4a92b;
          Tue, 24 Feb 2026 18:21:28 +0000 (UTC)
Message-ID: <2422cafc-af49-43ff-99ae-999dea92f79a@schaufler-ca.com>
Date: Tue, 24 Feb 2026 10:21:25 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: danieldurning.work@gmail.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, john.johansen@canonical.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, mic@digikod.net,
 takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260220195405.30612-1-danieldurning.work@gmail.com>
 <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com>
 <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
 <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8550-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,paul-moore.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,namei.org,hallyn.com,canonical.com,linux.ibm.com,huawei.com,digikod.net,nttdata.co.jp,i-love.sakura.ne.jp,schaufler-ca.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,schaufler-ca.com:mid,paul-moore.com:email]
X-Rspamd-Queue-Id: 7A66618B6A7
X-Rspamd-Action: no action

On 2/24/2026 6:44 AM, Stephen Smalley wrote:
> On Mon, Feb 23, 2026 at 5:21 PM Paul Moore <paul@paul-moore.com> wrote:
>> I'm not going to argue with that, and perhaps that is a good next
>> step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
>> that drops setting the S_PRIVATE flag to see if they complain too
>> loudly.  Based on other threads, Christian is aware that we are
>> starting to look at better/proper handling of pidfds/pidfs so he may
>> be open to dropping S_PRIVATE since it doesn't really have much impact
>> outside of the LSM, but who knows; the VFS folks have been growing a
>> bit more anti-LSM as of late.
> Adding S_PRIVATE to pidfs inodes was originally motivated by this bug report:
> https://lore.kernel.org/linux-fsdevel/20240222190334.GA412503@dev-arch.thelio-3990X/
> when pidfs was first introduced as its own distinct filesystem type.
> Otherwise, Fedora (and likely any other system enforcing SELinux)
> stopped working.

Woof. Not a hill I'm willing to receive even minor injuries on. Carry on.


