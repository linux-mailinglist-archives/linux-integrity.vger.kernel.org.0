Return-Path: <linux-integrity+bounces-39-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A17E9A5A
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 11:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6311C208F7
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED741CA90;
	Mon, 13 Nov 2023 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097C1C6B3
	for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2023 10:35:23 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A1D75
	for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2023 02:35:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4STQPl0ckSz9v7c9
	for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2023 18:18:51 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD35HTZ+1Fl6ZqVAA--.7596S2;
	Mon, 13 Nov 2023 11:35:11 +0100 (CET)
Message-ID: <7fecc3708577f74ab279b64c1ca60f3a5774101f.camel@huaweicloud.com>
Subject: Re: [ima-evm-utils PATCH 14/14] tests: Address issues raised by
 shellcheck SC2003
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 Nov 2023 11:35:01 +0100
In-Reply-To: <20231110202137.3978820-15-stefanb@linux.ibm.com>
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
	 <20231110202137.3978820-15-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD35HTZ+1Fl6ZqVAA--.7596S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxKFWkGw4kJF1xXw13Arb_yoW8uw4rpa
	95Wa48tr9YgFyqyF13GanFyr1rGr48Aw15uFn8Xw47Xr15Xry3Ar4fKrW3GrZIgr4FvrWf
	Aay0qFWfu392v3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj5JcHwAAsm
X-CFilter-Loop: Reflected

On Fri, 2023-11-10 at 15:21 -0500, Stefan Berger wrote:
> Address issues detected by shellcheck SC2003:
>   expr is antiquated. Consider rewriting this using $((..)), ${} or [[ ]]=
.
>=20
> The following statement in portable_signatures.test causes the issue:
>=20
>   expr index "$TST_LIST" "check_evm_revalidate"
>=20
> The man page for expr states:
>=20
>        index STRING CHARS
>               index in STRING where any CHARS is found, or 0
>=20
> The intention is certainly not to find an index of any of the characters
> in "check_evm_revalidate" in $TST_LIST but to find the word
> "check_evm_revalidate" in $TST_LIST. Therefore, use grep -w to determine
> whether the word is there.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
>  tests/Makefile.am              | 2 --
>  tests/portable_signatures.test | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index a5ee424..18b134c 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -27,8 +27,6 @@ distclean: distclean-keys
> =20
>  shellcheck:
>  	shellcheck \
> -		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
> -		-i SC2294,SC2206,SC2196,SC2043,SC2295 \
>  		functions.sh gen-keys.sh install-fsverity.sh \
>  		install-mount-idmapped.sh install-openssl3.sh \
>  		install-swtpm.sh install-tss.sh softhsm_setup \
> diff --git a/tests/portable_signatures.test b/tests/portable_signatures.t=
est
> index 5251211..c6e2d99 100755
> --- a/tests/portable_signatures.test
> +++ b/tests/portable_signatures.test
> @@ -1090,7 +1090,7 @@ if [ $((evm_value & EVM_INIT_X509)) -ne "$EVM_INIT_=
X509" ] && [ "$TST_EVM_CHANGE
>  	echo "$EVM_INIT_X509" > /sys/kernel/security/evm 2> /dev/null
>  fi
> =20
> -if [ "$(expr index "$TST_LIST" "check_evm_revalidate")" -gt 0 ] && [ "$T=
ST_EVM_CHANGE_MODE" -eq 1 ]; then
> +if echo "$TST_LIST" | grep -q -w check_evm_revalidate && [ "$TST_EVM_CHA=
NGE_MODE" -eq 1 ]; then
>  	echo "$EVM_ALLOW_METADATA_WRITES" > /sys/kernel/security/evm 2> /dev/nu=
ll
>  fi
> =20


