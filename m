Return-Path: <linux-integrity+bounces-6806-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81875B23492
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 20:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206B13BF7A6
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB02B2FD1DC;
	Tue, 12 Aug 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="p3benh/c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA82FAC11;
	Tue, 12 Aug 2025 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023849; cv=none; b=JKYaAtbUqsldfJ388knNiMVCB6zDSwUTwReiJSE4ODmO+2mxlQSHKnKx1IP2byb4voAvKuOU122wjoEXCdvsoZ/1kA3GO2q9XHxix6mpGOKT1jEz7ZnG+nm6KcVXpRNMDJ/HYYW5qMgpExOef0tPrj9WEsjT9i9o7I85AbK/JgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023849; c=relaxed/simple;
	bh=xcnGTZtYlth6EZ/IHO8VTTtnkpJcH001s+VVnUOYNN4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pl5mYza2VqQjhVccWY//pZ1mgnvVVcmqgFani5sTrU1G7rBL2WThKyoy3v90+vb+GrUdTlyclcfBGXbX6jMlUs34V+hWT6tx3kal7U3vGSjnIW94pHsGz0Dhf3hbPq51hSTN3KMrcw3Gf59nIn0D0eiBXyquHpZg4pXFkDHdI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=p3benh/c; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tCXf5eAPOEB1mU7Sfj6ozuynE635YDXwwF3ucaUJytk=; t=1755023847;
	x=1755628647; b=p3benh/cBlyqqPvoVLfyrD/6KrvAsbBo4Qyd+dxiKQGk86L0s/wdnWlyS0bb3
	g8kUXi/ReiwnF3t5Fu/m44AfLPGAL0CyiQjdMseVO7g49gh9IXXgr1+RlSiNBxql14AxumZElLD+l
	TK7+3nQocmoHkdGlbUYtOvHOmbJ1O7xZBFDtKARDDZ3sfd5LGP489GnNUJ6qnyAWZmBanAILxXgwx
	lTjJ5pMaF8mhMxiK66M/tvbvdPddegTDINUccPOGTARsXZDIjgQy4OpvHqP6Mt591Jf6/Sls1uBRc
	DeBmqT7HkHK0Vbd4eGIvQ6VOmrOEaL7ffAD6zDkFUD/d0QNDsg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ults4-00000001ygC-2Asi; Tue, 12 Aug 2025 20:37:16 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ults4-00000003t27-0yiV; Tue, 12 Aug 2025 20:37:16 +0200
Message-ID: <49b112b80b211ae05b5f3c36a55f67041783f51e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v5 18/23] bpf: Use vmalloc special flag
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "peterz@infradead.org"
	 <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, 
 "luto@kernel.org"
	 <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Cc: "sam@gentoo.org" <sam@gentoo.org>, "andreas@gaisler.com"	
 <andreas@gaisler.com>, "nadav.amit@gmail.com" <nadav.amit@gmail.com>, 
 "dave.hansen@linux.intel.com"	 <dave.hansen@linux.intel.com>,
 "anthony.yznaga@oracle.com"	 <anthony.yznaga@oracle.com>,
 "akpm@linux-foundation.org"	 <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,  "linux_dti@icloud.com"	
 <linux_dti@icloud.com>, "deneen.t.dock@intel.com"
 <deneen.t.dock@intel.com>,  "linux-mm@kvack.org"	 <linux-mm@kvack.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, 
 "linux-security-module@vger.kernel.org"	
 <linux-security-module@vger.kernel.org>, "sparclinux@vger.kernel.org"	
 <sparclinux@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
 "linux-integrity@vger.kernel.org"	 <linux-integrity@vger.kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "kernel-hardening@lists.openwall.com"	
 <kernel-hardening@lists.openwall.com>, "ast@kernel.org" <ast@kernel.org>, 
 "x86@kernel.org"	 <x86@kernel.org>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>
Date: Tue, 12 Aug 2025 20:37:15 +0200
In-Reply-To: <1738e24239cc0c001245fdd4bd3811175c573ce2.camel@intel.com>
References: <20190426001143.4983-1-namit@vmware.com>
		 <20190426001143.4983-19-namit@vmware.com>
		 <14437e403ed8fceacafe0a89521d3b731211156e.camel@physik.fu-berlin.de>
	 <1738e24239cc0c001245fdd4bd3811175c573ce2.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Tue, 2025-08-12 at 18:03 +0000, Edgecombe, Rick P wrote:
> On Tue, 2025-08-12 at 18:43 +0200, John Paul Adrian Glaubitz wrote:
> > I suspect that the main issue is to be found in the following patch whi=
ch introduced VM_FLUSH_RESET_PERMS
> > which may not work as expected on sun4u SPARC systems:
>=20
> I think the problem we found with VM_FLUSH_RESET_PERMS was that the sparc=
64
> kernel TLB flush implementation was broken. Since VM_FLUSH_RESET_PERMS ca=
used
> kernel TLB flushes to happen sooner, it just showed up sooner. [0]=20
>=20
> This other issue seems to be about userspace memory. So I wonder if these=
 are
> two separate issues? Bisecting to the original VM_FLUSH_RESET_PERMS would=
 have
> had the known sparc kernel range TLB flush issue. So to bisect the other =
issue
> you might need to apply this [1].

That could be true. I knew about the patch in [1] but I didn't think of app=
lying it.

FWIW, the crashes we're seeing on recent kernel versions look like this:

[   40.992851]               \|/ ____ \|/
[   40.992851]               "@'/ .. \`@"
[   40.992851]               /_| \__/ |_\
[   40.992851]                  \__U_/
[   41.186220] (udev-worker)(88): Kernel illegal instruction [#1]
[   41.262910] CPU: 0 UID: 0 PID: 88 Comm: (udev-worker) Tainted: G        =
W          6.12.0+ #25
[   41.376151] Tainted: [W]=3DWARN
[   41.415025] TSTATE: 0000004411001607 TPC: 00000000101c21c0 TNPC: 0000000=
0101c21c4 Y: 00000000    Tainted: G        W        =20
[   41.563717] TPC: <ehci_init_driver+0x0/0x160 [ehci_hcd]>
[   41.633584] g0: 00000000012005b8 g1: 00000000100a1800 g2: 00000000102060=
00 g3: 00000000101de000
[   41.747962] g4: fff000000a5af380 g5: 0000000000000000 g6: fff000000aac80=
00 g7: 0000000000000e7b
[   41.862338] o0: 0000000010060118 o1: 000000001020a000 o2: fff000000aa30c=
e0 o3: 0000000000000e7a
[   41.976728] o4: 00000000ff000000 o5: 00ff000000000000 sp: fff000000aacb0=
91 ret_pc: 00000000101de028
[   42.095768] RPC: <ehci_pci_init+0x28/0x2000 [ehci_pci]>
[   42.164394] l0: 0000000000000000 l1: 0000000100043fff l2: ffffffffff8000=
00 l3: 0000000000800000
[   42.278768] l4: fff00000001c8008 l5: 0000000000000000 l6: 00000000013358=
e0 l7: 0000000001002800
[   42.393143] i0: ffffffffffffffed i1: 00000000004db8d8 i2: 00000000000000=
00 i3: fff000000aa304e0
[   42.507517] i4: 0000000001127250 i5: 0000000010060000 i6: fff000000aacb1=
41 i7: 0000000000427d90
[   42.621893] I7: <do_one_initcall+0x30/0x200>
[   42.677931] Call Trace:
[   42.709953] [<0000000000427d90>] do_one_initcall+0x30/0x200
[   42.783158] [<00000000004db908>] do_init_module+0x48/0x240
[   42.855214] [<00000000004dd82c>] load_module+0x19cc/0x1f20
[   42.927270] [<00000000004ddf8c>] init_module_from_file+0x6c/0xa0
[   43.006189] [<00000000004de1e4>] sys_finit_module+0x1c4/0x2c0
[   43.081677] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
[   43.158307] Disabling lock debugging due to kernel taint
[   43.228077] Caller[0000000000427d90]: do_one_initcall+0x30/0x200
[   43.306995] Caller[00000000004db908]: do_init_module+0x48/0x240
[   43.384772] Caller[00000000004dd82c]: load_module+0x19cc/0x1f20
[   43.462544] Caller[00000000004ddf8c]: init_module_from_file+0x6c/0xa0
[   43.547184] Caller[00000000004de1e4]: sys_finit_module+0x1c4/0x2c0
[   43.628389] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
[   43.710741] Caller[fff000010480e2fc]: 0xfff000010480e2fc
[   43.780508] Instruction DUMP:
[   43.780511]  00000000=20
[   43.819394]  00000000=20
[   43.850273]  00000000=20
[   43.881153] <00000000>
[   43.912036]  00000000=20
[   43.942917]  00000000=20
[   43.973797]  00000000=20
[   44.004678]  00000000=20
[   44.035561]  00000000=20
[   44.066443]

Do you have any suggestion what to bisect?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

