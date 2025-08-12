Return-Path: <linux-integrity+bounces-6804-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4FB22E41
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D1D3AD7F7
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1922FA0F7;
	Tue, 12 Aug 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="YECTfUAG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA5305E08;
	Tue, 12 Aug 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017029; cv=none; b=AD6fcRWnZpBSRZELsq4zTkzDQ+GNqPMyiKReBPhSqiYpGvbkRDEiDTPu41Dfikb0NvjSeLqs6wU65OF/YlgLjgbRHhuWcJszebv+vZbIVsAigPxMgqWiiVjhmD96TW9AGHkxVQFEZvlh+/xLeghrL96pi3IHjVjbmyHtbbo01Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017029; c=relaxed/simple;
	bh=8OHeXsUnP/hB6ULQyVFiZvCvP20PydvcxVnugd0BKbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ay5C8AdkpveZt7ln2i6n1dqjvWu+69IWB9FGMiQFJtxhU4islT/Mi2mYjjxb3cK7aBCo79pTpolnCG/Rp9DbyOgmlL66ruap5pNpNWW1ISVb7fx9eI8I8gk6GmaxR6a1wd5Xp+4zb25LLQjuVNd8ncbp+2Ok4VMxdHI2aeSnJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=YECTfUAG; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=F9dW/4iPMQ9pYAHKxgNEzdnUjAU00Blu1hvGt1FirHY=; t=1755017026;
	x=1755621826; b=YECTfUAGeP7bXucHMU/RKJCysTjsun35Sx+OZFBAQnME7eJ2TYbIY4kZjEXK0
	nxYUarwyRvSS/gOrjkul9FA0tqzR95QihyNqT6ndJeRLPe3IDUd8hbvYMGRp+p4FTlnElMwIZ4aJF
	PXuicuHNjsBeAw891tfPI2nxYfHWMe9EN0oykCUZsR6DkmbldVSaQQwZnA31N1xbtIE92NCPueQzu
	xlF+st/j0RT7xWLncEPfnorT3GmT/xkIKVCtpgxxWzK2sjy9lbaZAc7T4vadTus6QmTRQxTVqAf4b
	zh6mp1u6Z0FSF0eFFy57mYAL/URmv5ARb5tr/gPksVt7zidTUg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uls61-00000001TuI-1fQO; Tue, 12 Aug 2025 18:43:33 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uls61-00000003X5B-0Jat; Tue, 12 Aug 2025 18:43:33 +0200
Message-ID: <14437e403ed8fceacafe0a89521d3b731211156e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v5 18/23] bpf: Use vmalloc special flag
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Nadav Amit <namit@vmware.com>, Peter Zijlstra <peterz@infradead.org>, 
 Borislav Petkov	 <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Ingo
 Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, Thomas
 Gleixner	 <tglx@linutronix.de>, Nadav Amit <nadav.amit@gmail.com>, Dave
 Hansen	 <dave.hansen@linux.intel.com>, linux_dti@icloud.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	akpm@linux-foundation.org, kernel-hardening@lists.openwall.com, 
	linux-mm@kvack.org, will.deacon@arm.com, ard.biesheuvel@linaro.org, 
	kristen@linux.intel.com, deneen.t.dock@intel.com, Rick Edgecombe	
 <rick.p.edgecombe@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, sparclinux
 <sparclinux@vger.kernel.org>, Sam James <sam@gentoo.org>,  Andreas Larsson
 <andreas@gaisler.com>, Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Tue, 12 Aug 2025 18:43:31 +0200
In-Reply-To: <20190426001143.4983-19-namit@vmware.com>
References: <20190426001143.4983-1-namit@vmware.com>
	 <20190426001143.4983-19-namit@vmware.com>
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

On Thu, 2019-04-25 at 17:11 -0700, Nadav Amit wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>=20
> Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
> permissioned memory in vmalloc and remove places where memory was set RW
> before freeing which is no longer needed. Don't track if the memory is RO
> anymore because it is now tracked in vmalloc.
>=20
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  include/linux/filter.h | 17 +++--------------
>  kernel/bpf/core.c      |  1 -
>  2 files changed, 3 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 14ec3bdad9a9..7d3abde3f183 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -20,6 +20,7 @@
>  #include <linux/set_memory.h>
>  #include <linux/kallsyms.h>
>  #include <linux/if_vlan.h>
> +#include <linux/vmalloc.h>
> =20
>  #include <net/sch_generic.h>
> =20
> @@ -503,7 +504,6 @@ struct bpf_prog {
>  	u16			pages;		/* Number of allocated pages */
>  	u16			jited:1,	/* Is our filter JIT'ed? */
>  				jit_requested:1,/* archs need to JIT the prog */
> -				undo_set_mem:1,	/* Passed set_memory_ro() checkpoint */
>  				gpl_compatible:1, /* Is filter GPL compatible? */
>  				cb_access:1,	/* Is control block accessed? */
>  				dst_needed:1,	/* Do we need dst entry? */
> @@ -733,27 +733,17 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 siz=
e_default)
> =20
>  static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
>  {
> -	fp->undo_set_mem =3D 1;
> +	set_vm_flush_reset_perms(fp);
>  	set_memory_ro((unsigned long)fp, fp->pages);
>  }
> =20
> -static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
> -{
> -	if (fp->undo_set_mem)
> -		set_memory_rw((unsigned long)fp, fp->pages);
> -}
> -
>  static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
>  {
> +	set_vm_flush_reset_perms(hdr);
>  	set_memory_ro((unsigned long)hdr, hdr->pages);
>  	set_memory_x((unsigned long)hdr, hdr->pages);
>  }
> =20
> -static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hd=
r)
> -{
> -	set_memory_rw((unsigned long)hdr, hdr->pages);
> -}
> -
>  static inline struct bpf_binary_header *
>  bpf_jit_binary_hdr(const struct bpf_prog *fp)
>  {
> @@ -789,7 +779,6 @@ void __bpf_prog_free(struct bpf_prog *fp);
> =20
>  static inline void bpf_prog_unlock_free(struct bpf_prog *fp)
>  {
> -	bpf_prog_unlock_ro(fp);
>  	__bpf_prog_free(fp);
>  }
> =20
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ff09d32a8a1b..c605397c79f0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -848,7 +848,6 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
>  	if (fp->jited) {
>  		struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
> =20
> -		bpf_jit_binary_unlock_ro(hdr);
>  		bpf_jit_binary_free(hdr);
> =20
>  		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
> --=20
> 2.17.1
>=20
>=20
> From mboxrd@z Thu Jan  1 00:00:00 1970
> From: Nadav Amit <namit@vmware.com>
> Subject: [PATCH v5 18/23] bpf: Use vmalloc special flag
> Date: Thu, 25 Apr 2019 17:11:38 -0700
> Message-ID: <20190426001143.4983-19-namit@vmware.com>
> In-Reply-To: <20190426001143.4983-1-namit@vmware.com>
> References: <20190426001143.4983-1-namit@vmware.com>
> MIME-Version: 1.0
> Content-Type: text/plain
> To: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>=
, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
> Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, Thomas G=
leixner <tglx@linutronix.de>, Nadav Amit <nadav.amit@gmail.com>, Dave Hanse=
n <dave.hansen@linux.intel.com>, linux_dti@icloud.com, linux-integrity@vger=
.kernel.org, linux-security-module@vger.kernel.org, akpm@linux-foundation.o=
rg, kernel-hardening@lists.openwall.com, linux-mm@kvack.org, will.deacon@ar=
m.com, ard.biesheuvel@linaro.org, kristen@linux.intel.com, deneen.t.dock@in=
tel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>, Daniel Borkmann <dani=
el@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>
> List-ID: <kernel-hardening.lists.openwall.com>
>=20
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>=20
> Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
> permissioned memory in vmalloc and remove places where memory was set RW
> before freeing which is no longer needed. Don't track if the memory is RO
> anymore because it is now tracked in vmalloc.
>=20
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  include/linux/filter.h | 17 +++--------------
>  kernel/bpf/core.c      |  1 -
>  2 files changed, 3 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 14ec3bdad9a9..7d3abde3f183 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -20,6 +20,7 @@
>  #include <linux/set_memory.h>
>  #include <linux/kallsyms.h>
>  #include <linux/if_vlan.h>
> +#include <linux/vmalloc.h>
> =20
>  #include <net/sch_generic.h>
> =20
> @@ -503,7 +504,6 @@ struct bpf_prog {
>  	u16			pages;		/* Number of allocated pages */
>  	u16			jited:1,	/* Is our filter JIT'ed? */
>  				jit_requested:1,/* archs need to JIT the prog */
> -				undo_set_mem:1,	/* Passed set_memory_ro() checkpoint */
>  				gpl_compatible:1, /* Is filter GPL compatible? */
>  				cb_access:1,	/* Is control block accessed? */
>  				dst_needed:1,	/* Do we need dst entry? */
> @@ -733,27 +733,17 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 siz=
e_default)
> =20
>  static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
>  {
> -	fp->undo_set_mem =3D 1;
> +	set_vm_flush_reset_perms(fp);
>  	set_memory_ro((unsigned long)fp, fp->pages);
>  }
> =20
> -static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
> -{
> -	if (fp->undo_set_mem)
> -		set_memory_rw((unsigned long)fp, fp->pages);
> -}
> -
>  static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
>  {
> +	set_vm_flush_reset_perms(hdr);
>  	set_memory_ro((unsigned long)hdr, hdr->pages);
>  	set_memory_x((unsigned long)hdr, hdr->pages);
>  }
> =20
> -static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hd=
r)
> -{
> -	set_memory_rw((unsigned long)hdr, hdr->pages);
> -}
> -
>  static inline struct bpf_binary_header *
>  bpf_jit_binary_hdr(const struct bpf_prog *fp)
>  {
> @@ -789,7 +779,6 @@ void __bpf_prog_free(struct bpf_prog *fp);
> =20
>  static inline void bpf_prog_unlock_free(struct bpf_prog *fp)
>  {
> -	bpf_prog_unlock_ro(fp);
>  	__bpf_prog_free(fp);
>  }
> =20
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ff09d32a8a1b..c605397c79f0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -848,7 +848,6 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
>  	if (fp->jited) {
>  		struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
> =20
> -		bpf_jit_binary_unlock_ro(hdr);
>  		bpf_jit_binary_free(hdr);
> =20
>  		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));

There are issues with the TLB management on sparc64 (primarily sun4u) that =
were introduced
by this patch. A typical backtrace after a crash looks like this:

[  122.085803] Unable to handle kernel NULL pointer dereference
[  122.160227] tsk->{mm,active_mm}->context =3D 000000000000009d
[  122.233502] tsk->{mm,active_mm}->pgd =3D fff0000231d14000
[  122.302118]               \|/ ____ \|/
[  122.302118]               "@'/ .. \`@"
[  122.302118]               /_| \__/ |_\
[  122.302118]                  \__U_/
[  122.495420] systemd(1): Oops [#1]
[  122.538874] CPU: 0 PID: 1 Comm: systemd Not tainted 5.2.0-3-sparc64 #1 D=
ebian 5.2.17-1
[  122.642957] TSTATE: 0000004411001601 TPC: 000000000061cd94 TNPC: 0000000=
00061cd98 Y: 00000000    Not tainted
[  122.772207] TPC: <vfs_getattr_nosec+0x34/0xc0>
[  122.830529] g0: 0000000000000000 g1: 00000000000007ff g2: 00000000000000=
00 g3: 00000000000007df
[  122.944902] g4: fff00002381771c0 g5: 0000000000000003 g6: fff00002381780=
00 g7: 0000000000000000
[  123.059275] o0: fff000023817be18 o1: 0000000000000000 o2: 00000000000000=
00 o3: fff000023817be18
[  123.173658] o4: 0000000000000000 o5: 0000000000000000 sp: fff000023817b3=
41 ret_pc: 000000000061cd7c
[  123.292611] RPC: <vfs_getattr_nosec+0x1c/0xc0>
[  123.350933] l0: 0000010000204010 l1: fff0000101600e28 l2: e4e45b5b8ae446=
28 l3: 0000000000000000
[  123.465311] l4: 0000000000000000 l5: 0000000000000000 l6: 00000000000000=
00 l7: fff0000100bff140
[  123.579692] i0: fff000023817bd50 i1: fff000023817be18 i2: 00000000000000=
01 i3: 0000000000000900
[  123.694060] i4: 0000000000000000 i5: fff00002320c1210 i6: fff000023817b3=
f1 i7: 000000000061ce48
[  123.808439] I7: <vfs_getattr+0x28/0x40>
[  123.858759] Call Trace:
[  123.890785]  [000000000061ce48] vfs_getattr+0x28/0x40
[  123.957123]  [000000000061cf64] vfs_statx+0x84/0xc0
[  124.021173]  [000000000061d918] sys_statx+0x38/0x60
[  124.085226]  [0000000000406154] linux_sparc_syscall+0x34/0x44
[  124.160708] Disabling lock debugging due to kernel taint
[  124.230481] Caller[000000000061ce48]: vfs_getattr+0x28/0x40
[  124.303680] Caller[000000000061cf64]: vfs_statx+0x84/0xc0
[  124.374593] Caller[000000000061d918]: sys_statx+0x38/0x60
[  124.445503] Caller[0000000000406154]: linux_sparc_syscall+0x34/0x44
[  124.527857] Caller[fff00001013fde40]: 0xfff00001013fde40
[  124.597621] Instruction DUMP:
[  124.597623]  c2264000=20
[  124.636505]  861027df=20
[  124.667386]  c45f6028=20
[  124.698267] <c458a050>
[  124.729148]  8408a401=20
[  124.760031]  83789403=20
[  124.790910]  c2264000=20
[  124.821801]  c207600c=20
[  124.852675]  80886800=20
[  124.883556]=20
[  124.954015] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000009
[  125.054721] Press Stop-A (L1-A) from sun keyboard or send break
[  125.054721] twice on console to return to the boot prom
[  125.201103] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x00000009 ]---

I suspect that the main issue is to be found in the following patch which i=
ntroduced VM_FLUSH_RESET_PERMS
which may not work as expected on sun4u SPARC systems:

commit 868b104d7379e28013e9d48bdd2db25e0bdcf751
Author: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date:   Thu Apr 25 17:11:36 2019 -0700

    mm/vmalloc: Add flag for freeing of special permsissions
  =20
    Add a new flag VM_FLUSH_RESET_PERMS, for enabling vfree operations to
    immediately clear executable TLB entries before freeing pages, and hand=
le
    resetting permissions on the directmap. This flag is useful for any kin=
d
    of memory with elevated permissions, or where there can be related
    permissions changes on the directmap. Today this is RO+X and RO memory.
  =20
    Although this enables directly vfreeing non-writeable memory now,
    non-writable memory cannot be freed in an interrupt because the allocat=
ion
    itself is used as a node on deferred free list. So when RO memory needs=
 to
    be freed in an interrupt the code doing the vfree needs to have its own
    work queue, as was the case before the deferred vfree list was added to
    vmalloc.
  =20
    For architectures with set_direct_map_ implementations this whole opera=
tion
    can be done with one TLB flush when centralized like this. For others w=
ith
    directmap permissions, currently only arm64, a backup method using
    set_memory functions is used to reset the directmap. When arm64 adds
    set_direct_map_ functions, this backup can be removed.
  =20
    When the TLB is flushed to both remove TLB entries for the vmalloc rang=
e
    mapping and the direct map permissions, the lazy purge operation could =
be
    done to try to save a TLB flush later. However today vm_unmap_aliases
    could flush a TLB range that does not include the directmap. So a helpe=
r
    is added with extra parameters that can allow both the vmalloc address =
and
    the direct mapping to be flushed during this operation. The behavior of=
 the
    normal vm_unmap_aliases function is unchanged.
  =20
    Suggested-by: Dave Hansen <dave.hansen@intel.com>
    Suggested-by: Andy Lutomirski <luto@kernel.org>
    Suggested-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: <akpm@linux-foundation.org>
    Cc: <ard.biesheuvel@linaro.org>
    Cc: <deneen.t.dock@intel.com>
    Cc: <kernel-hardening@lists.openwall.com>
    Cc: <kristen@linux.intel.com>
    Cc: <linux_dti@icloud.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Nadav Amit <nadav.amit@gmail.com>
    Cc: Rik van Riel <riel@surriel.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Link: https://lkml.kernel.org/r/20190426001143.4983-17-namit@vmware.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

The crash will always happen when support for transparent huge pages is ena=
bled (CONFIG_TRANSPARENT_HUGEPAGE=3Dy
and CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy) and in particular on sun4u mach=
ines (but not so much the more modern
sun4v machines although I cannot rule out that the crashes sometimes happen=
ing on these machines is related
to this bug).

With THP enabled, the crash can be delayed by either reverting d563d678aa0b=
 or, for example, by this crude hack:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6dbcdceecae1..128118593b48 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2948,8 +2948,8 @@ static void _vm_unmap_aliases(unsigned long start, un=
signed long end, int flush)
        }
        free_purged_blocks(&purge_list);
=20
-       if (!__purge_vmap_area_lazy(start, end, false) && flush)
-               flush_tlb_kernel_range(start, end);
+       //      if (!__purge_vmap_area_lazy(start, end, false) && flush)
+       //      flush_tlb_kernel_range(start, end);
        mutex_unlock(&vmap_purge_lock);
 }

Please see also the discussion in [1].

Thanks,
Adrian

> [1] https://lore.kernel.org/all/35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.=
camel@physik.fu-berlin.de/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

