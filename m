Return-Path: <linux-integrity+bounces-9478-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eILOGH6I/GleRAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9478-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 14:41:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A474E8508
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 14:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1723A300AB26
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4693A7F61;
	Thu,  7 May 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VGCYBaQN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B492D37188B;
	Thu,  7 May 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157688; cv=none; b=HDeGiVuxdXYTlampmjnR3YQb27gh9UhrZTfbjSYlc7xjhSwJR6GGvupZMgKEXQmJOW1+7n/FbfzbX19Rx5hW4vzKLgUqZzFbs39MFxOFbfrpQh50nA3dN6GesxE3i5N1QhUa643Zqfm5a58exfyq3P3H3RjHPnKp/GDiEaHIjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157688; c=relaxed/simple;
	bh=sTsBvU4Fzz+iiGGH3yqZBRL+Z8mLDkTa59nepj1Pgjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCheWwAS32c/N56U9H0aCkPm9RjOlNtiIf6hiDQdkTm83S4a0XrpN2HD39Ac/P+odrx/k2EcAO8MsS2ft9GGrIJaN1WS9IT48oNVaO+nWjpcyNYkuh1QNLxkCiIUsl4CSpaubM0VGSkMD/IcWVR6G/hDSwQEdCZdOVIwcMUJYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VGCYBaQN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FCCC2364;
	Thu,  7 May 2026 05:41:20 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B56573F836;
	Thu,  7 May 2026 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778157685; bh=sTsBvU4Fzz+iiGGH3yqZBRL+Z8mLDkTa59nepj1Pgjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGCYBaQNxoRLwK2ShKB/DE8OFEUI/JS5gPey6KF9NtYZEg71Rkp/9BYHDh3l1M4C3
	 eWRtBOSTCa7+nqERcQJp0ZzCZKAmmnTHWsJitjta2UcL2MYI10+O2Xvq6XbkZn573q
	 16wegKAyEOZg6euogahHn/IBLmCnghpuHejC93Q4=
Date: Thu, 7 May 2026 13:41:17 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Safford <david.safford@gmail.com>,
	Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
Message-ID: <afyIbW5cljh5ZvTL@e129823.arm.com>
References: <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
 <202f90682fe47bb5fb9b08f8678ae00981b5290b.camel@linux.ibm.com>
 <201b9172ac47c6766443c1f2343cab3548f33c29.camel@linux.ibm.com>
 <afrXmRiq7XvSe6yN@e129823.arm.com>
 <9ff4853a8e9932b3a1424f2a6c3347f1723fb5f4.camel@linux.ibm.com>
 <aftIuPwNeuzc9nY1@e129823.arm.com>
 <9d1af933ef218b159762884357d127e3644dfe2c.camel@linux.ibm.com>
 <afwoDgaJxmKwOhXp@e129823.arm.com>
 <f19081f1eda19d6d1ae133d8ec93e779ab1a25e5.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19081f1eda19d6d1ae133d8ec93e779ab1a25e5.camel@linux.ibm.com>
X-Rspamd-Queue-Id: B7A474E8508
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-9478-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Mimi,

> On Thu, 2026-05-07 at 06:50 +0100, Yeoreum Yun wrote:
> > Hi Mimi,
> > 
> > > On Wed, 2026-05-06 at 14:57 +0100, Yeoreum Yun wrote:
> > > > > > > On both Z and PowerVM, there are ~30 measurements between boot_aggregate and
> > > > > > > boot_aggregate_late.  For example, on PowerVM:
> > > > > > > 
> > > > > > > # grep -n boot_aggregate
> > > > > > > /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> > > > > > > 
> > > > > > > 1:10 f60a05d7354fb34aabc02965216abd3428ea52bb ima-sig
> > > > > > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > > > > > > boot_aggregate 
> > > > > > > 31:10 e2592b0d61da6300d3db447b143897a9792231ea ima-sig
> > > > > > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > > > > > > boot_aggregate_late
> > > > > > > 
> > > > > > > It would be interesting to the results from a Raspberry Pi 5 as well,
> > > > > > > with/without a TPM.
> > > > > > 
> > > > > > Honestly, I find this result hard to accept.
> > > > > > 
> > > > > > This effectively means that there is code invoking IMA measurement during late_initcall().
> > > > > > It also implies that if, in the future, a late_initcall is added that performs
> > > > > > an IMA measurement before IMA initialization has occurred accoding to order by linker,
> > > > > > that measurement could be missed.
> > > > > 
> > > > > Exactly.  The results are simply from booting with the builtin "tcb" and
> > > > > "critical_data" policies.
> > > > > 
> > > > > $ sudo grubby --args="ima_policy=\"tcb|critical_data\"" --update-kernel
> > > > > /boot/vmlinuz-${SUFFIX}
> > > > 
> > > > Thanks. but I still wonder what meaasurements there are between
> > > > boot_aggregate and boot_aggregate_late.
> > > > Might be there would be key measurements if it takes more than
> > > > 5 mins before generating boot_aggregate_late but this seems rare.
> > > > 
> > > > If you don't mind, would you share the contents of the log between
> > > > boot_aggregate and boot_aggregate_late?
> > > > since I only get a kernel_version in my environment.
> > > 
> > >      1	10 f60a05d7354fb34aabc02965216abd3428ea52bb ima-sig
> > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > > boot_aggregate 
> > >      2	10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf
> > > sha256:0c907aab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2
> > > kernel_version 372e312e302d7263312b
> > >      3	10 92c40bfd65512d5224cddb9fb64fef0d72e1c182 ima-sig
> > > sha256:412bae0d0e85a99971d6eda198dd2fed3c2959715e8a17a4caddc7bc605bdeeb
> > > /usr/bin/kmod 
> > >      4	10 a18f997e1e82d0ef416f93683966d7dda875d71c ima-sig
> > > sha256:0050fcc672e03cfdc3a50c771ca9f5219478e5538980a26fd4484620712d8163
> > > /usr/lib64/ld64.so.2 
> > >      5	10 88f343618caeeed92ed8281d627f4565b0499d66 ima-sig
> > > sha256:a0e83c084d8c227f1150a8cd94eece61f62bc1da30f98d1cf57ca7db241a9c45
> > > /etc/ld.so.cache 
> > >      6	10 e047868f01908eb95aa180693291decab82bb6be ima-sig
> > > sha256:42ebf9cc684419de4d8a1d624102716d88fbcf957f47e50a9a08e38b338023ac
> > > /usr/lib64/libzstd.so.1.5.5 
> > >      7	10 da069bc6a44d454510a76c69d3a54c3b238ae27e ima-sig
> > > sha256:9b7c788e75c16c8827062016cf15826e43661c4b5b56813ea07ff2635bea2710
> > > /usr/lib64/liblzma.so.5.6.2 
> > >      8	10 7ade414e736e7b449cda5ec5e0277b99548e89c6 ima-sig
> > > sha256:d899452e8e6369e436ba1a565833d6dcf0d09c35e40ffc0979cf4de2bdb8f421
> > > /usr/lib64/libz.so.1.3.1.zlib-ng 
> > >      9	10 9a9da8326f36237a47d6ed21bdffd0e1ff855e2a ima-sig
> > > sha256:a848f396db7ad135f851b5e9aeb32f4a3ef1439c7913b9b95ab1cda69251f6ad
> > > /usr/lib64/libcrypto.so.3.5.1 
> > >     10	10 3201d27cd4028f02fc9088ec33e2d0ceb72d2c5b ima-sig
> > > sha256:e52dcd1850555c08d60fefe56694c1179b4eaa5796db0907606552ece8e1bab1
> > > /usr/lib64/libgcc_s-14-20250617.so.1 
> > >     11	10 3b4c6f13e52ca060b290709f737b1ff66564226f ima-sig
> > > sha256:f2a900a5b980b289dc028dd3caab16b1b0ad037f2e875546bb3197d23ff241f0
> > > /usr/lib64/glibc-hwcaps/power10/libc.so.6 
> > >     12	10 b23b616cbd3c9dc4c5743d121c1c5a702b461a9c ima-sig
> > > sha256:5a682022beeea9ee7f36a70f0465942bf32e9675d3f45355088e148787e02175
> > > /usr/lib/modprobe.d/dist-alsa.conf 
> > >     13	10 aec07fad18697f295d7e06796fc8dfd3b472f9c3 ima-sig
> > > sha256:067d949bab3bb085d0936031881ff73b2ab39f34b9a90cbd01396d1987ff6658
> > > /usr/lib/modprobe.d/dist-blacklist.conf 
> > >     14	10 c402c56b66e65914148efd6e3cf0b1d616daabe6 ima-sig
> > > sha256:120a02e9b88ba74949224eca7385825e39880f5687f739ade07d94ee22ffe325
> > > /etc/modprobe.d/firewalld-sysctls.conf 
> > >     15	10 e358ca12bd58e1ce4845e299e1aea8b81edf86f9 ima-sig
> > > sha256:fa27abcd357a16ee1254ba38d1225b7f0724036c07ce3d0e83b29eb72d97c419
> > > /etc/modprobe.d/l2tp_eth-blacklist.conf 
> > >     16	10 4b036d41435d7df3a72b38880f5fe231904b7b66 ima-sig
> > > sha256:ecf5f948bfbfb726879a910b3174d139c8af6b1745c88dcc1e4a1cf532c02299
> > > /etc/modprobe.d/l2tp_ip-blacklist.conf 
> > >     17	10 9c53a7a48c1b5218417c4f25c4a34c09a9f39830 ima-sig
> > > sha256:f76c4ac232d5e96c57961a9f10194703b4df6d119530046f0b23eee70bfcb089
> > > /etc/modprobe.d/l2tp_ip6-blacklist.conf 
> > >     18	10 6c41d7b7d251c400b7e0ba76f7b386a746e8f4ec ima-sig
> > > sha256:5cbc958f893a599ef19437014696dd7b112cf9af6a4348830177f8a8f78aa1b3
> > > /etc/modprobe.d/l2tp_netlink-blacklist.conf 
> > >     19	10 f37ef48faef5bc51e29d47531726af0bd0654655 ima-sig
> > > sha256:7a3d63acb49e4a69b482f26624761b5778fbd6b77be8a3f36926b379b5f965ed
> > > /etc/modprobe.d/l2tp_ppp-blacklist.conf 
> > >     20	10 82ef59779acdfd6e9b35521bfa09e6ba86fd6174 ima-sig
> > > sha256:6a8f2009d87deba7a2de46e3d0c46b114fe388d188b00b9a382fc2156aabb676
> > > /usr/lib/modules/7.1.0-rc1+/modules.softdep 
> > >     21	10 6ae994e33a6313ab4535da90f5cb6c3beaec7b86 ima-sig
> > > sha256:268695dbf23bd0170ec9a95b10e8d596205fd7436617d10101907171bf004b7c
> > > /etc/modprobe.d/sctp-blacklist.conf 
> > >     22	10 b2c238ae66b03f56191d9955a5ad0f3110bb7e2b ima-sig
> > > sha256:64a8ebb0a1fd712a9aeb7aa0f0ad0b72d3277034c8bfa3b66ab063e201d6527e
> > > /etc/modprobe.d/sctp_diag-blacklist.conf 
> > >     23	10 c0443f2d3c078959ae86276df23abe172234a55d ima-sig
> > > sha256:e5a3958cbd3684b63f3cada6604469cc56f727b106d5524daf5aefa6935a48ce
> > > /usr/lib/modprobe.d/systemd.conf 
> > >     24	10 5c46e012bc7fffc3256b166282a7eaa4bea5fa33 ima-sig
> > > sha256:6560abcdd2cdb41e1d0fe73052298d612920d5bccb4a3a7c82bc73895128e760
> > > /etc/modprobe.d/tipc_diag-blacklist.conf 
> > >     25	10 d5fb1836364732fbc4f87aa7d2c984cf30bdbfd3 ima-sig
> > > sha256:358703c09ac2d2c653e11bbc7c65d378c8496e87ca47307f86c36b0b29640598
> > > /etc/modprobe.d/tuned.conf 
> > >     26	10 a85107163729f696f316d46c0bf3f65f713ba972 ima-sig
> > > sha256:7410bb4cec56892e8b0010c5c8b72be532784ccf0240aa0677c5be085a530f65
> > > /usr/lib/modules/7.1.0-rc1+/modules.dep.bin 
> > >     27	10 80eb261ffb2cc3528d90c33b1c624f657a045867 ima-sig
> > > sha256:856e0f083226f8b4fb7d1d71447fb841dae18ea9a50ea6d8505a206167288e1d
> > > /usr/lib/modules/7.1.0-rc1+/modules.alias.bin 
> > >     28	10 6af2d661da470d7a1c9909ddbc074d3d265eb1d7 ima-sig
> > > sha256:4853ca200598c52970c380fda99484068e7db4961a4f94faac6abcfbbd52d150
> > > /usr/lib/modules/7.1.0-rc1+/modules.symbols.bin 
> > >     29	10 6f9cd405bd57d925baae6ae66c273c61c90b3bc8 ima-sig
> > > sha256:193d1e1004848f7d391877507b69a7953e1f94ddbe70eb0e2cf6dc45fce7cd6a
> > > /usr/lib/modules/7.1.0-rc1+/modules.builtin.alias.bin 
> > >     30	10 4e20b980bf3a825a866be0c46033ed654df4aeba ima-sig
> > > sha256:3a0e3c56d51ba98258ff13f93f82c837de22f4b707d24678f82893babf4d77ea
> > > /usr/lib/modules/7.1.0-rc1+/modules.builtin.bin 
> > >     31	10 e2592b0d61da6300d3db447b143897a9792231ea ima-sig
> > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > > boot_aggregate_late 
> > >     32	10 81830cd3d799e006698258dc1b11fe29a56eeef5 ima-sig
> > > sha256:d1651dc50bb5b92c1badcab9aa4dbbca40cb704cdc707d1c536b41d7b1aa465e
> > > /usr/lib/systemd/systemd 
> > 
> > Hmm... Theses measurements seems to happen while populating
> > initramfs which triggers file_post_open as async
> > (and I see the RAMFS seems not part of DONT_MEASURE in IMA).
> > 
> > If you don't mind, Could you check whether this measurements still
> > happen with initramfs_async=0?
> > 
> > If this measurements aren't generated with above option,
> > there is a question whether let IMA measure initramfs which can be
> > measured or not depending on boot option or timing (some file measurements
> > could be lost all when do_populate_rootfs() executes concurrently while
> > running late_initcall).
> 
> There's no difference when adding the "initramfs_async=0" boot command line
> argument. The measurement list between boot_aggregate and boot_aggregate_late is
> exactly the same.
>

That's quite interesting. This means there're some file operation
between late_initcall and late_initcall_sync
even before run_init_process() except initramfs population.

Since initramfs population flush all fputs() it generates and
boot_aggregate_late is generated before init process is loaded,
I honestly have no idea who triggers above file operations.

And it seems a little bit weird that it opens the /usr/bin/kmod
and its configuration from kernel not by init_process or other user
process...

-- 
Sincerely,
Yeoreum Yun

