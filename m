Return-Path: <linux-integrity+bounces-3631-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F8A97C06B
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 21:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C241F22359
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725E1CB309;
	Wed, 18 Sep 2024 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="WBW8bOud"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFEA1CA6B4;
	Wed, 18 Sep 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687364; cv=none; b=U40WOOST2Y3Wlbno9ZJ7cYyi75y99ZxEE+YnwvLspoqltkYSrLJwEeE4K6PcsT1TPy3KCCCGrBk3uL6JlvpS3baFSbNqkLHZK/F2nTP1/tnL7WYJKdDLQXWuCVY2cg78r0EsuH3jt0xGgEdc7Ts31zzA6mQ+GwyXEcDQrif7JYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687364; c=relaxed/simple;
	bh=4xDBu5SBZ+E0jSRnHtj1f8JJHT5XWqUbCuenrQuFKgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdjAQmFX4WOwIy4LBOTh/1kYOl8OgC9/T/vOJCAFG5QoT8WMWk9JLdtt2rWTQDKbMbN2J77YfIBsVcN/dOLHbP3UjZlhIdJdbwgVfFltbcq4e1HWtspij5NZD25j6F9QR/s6byzrW/4gm01VqLUHpXId5fBTNTSc26mPtT6CWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=WBW8bOud; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48IFKxbo017862;
	Wed, 18 Sep 2024 19:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=BEnWRDS2OW2WxX4kuauLlDs
	3rxG6cwL0cz8qA69JXhg=; b=WBW8bOudvauVQ+lByhMrNAUTQQXRRc44YXKtmqY
	tX994jaPf70t8xaTfBaMlAUe60hBc9ZMkvOlXCesdzipkGfZOlhodHsAnuNDzLU/
	9b7Mof0wKi6jkqLH1NHy6pKDpj2oJ9880muHayoJ5y7SstaZ+ftlxynzaDYJ4CBj
	txcWqrDZ6Wh9q3CfcM9U+6dq9362ePesFqpyAObh7yXO8WyG6QucXTfAvxftQHJx
	b3Z3IOswS9KbYNdVYVOAVNdgfkmMHrS6VWwzCd3JaXZVserti3chYrwJCJyz44dN
	NOYyoZh3EQZ14s5ZJAB9R710mP5WlZXgwLPwu1n+B27n8GA==
Received: from iadlppfpol1.lenovo.com ([104.232.228.80])
	by m0355088.ppops.net (PPS) with ESMTPS id 41nqnt7h3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 19:22:12 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (unknown [100.65.83.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by iadlppfpol1.lenovo.com (Postfix) with ESMTPS id 4X87nZ3yGNz8ffJM;
	Wed, 18 Sep 2024 19:22:10 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4X87nY48hGz3nd85;
	Wed, 18 Sep 2024 19:22:09 +0000 (UTC)
Date: Wed, 18 Sep 2024 14:22:08 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Kees Cook <kees@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Andrew Wheeler <awheeler@motorola.com>,
        Sammy BS2 Que | =?utf-8?B?6ZiZ5paM55Sf?= <quebs2@motorola.com>,
        Neill Kapron <nkapron@google.com>, Todd Kjos <tkjos@google.com>,
        Viktor Martensson <vmartensson@google.com>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kernel-team <kernel-team@android.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC] Proposal: Static SECCOMP Policies
Message-ID: <hkwtlwrpowebiwv4yifjsgjc5plg2cczp7wfzzuqhzi7lsj6lp@i753ef5xqnga>
References: <SEZPR03MB6786D45BE387F2B378E71A84B4642@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <ZuNVqvVgXLjNXS5Y@google.com>
 <CANP3RGfez2onSLVT2wC1hsSmKGxD9aFdV3we3Zsngw0BgbeGyw@mail.gmail.com>
 <TYZPR03MB67922FFDE5C9C925D8274677B4652@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CANP3RGfwL1OigoSkhmnRFDy=y+sstabiRAREPxEbEiEfuDaweQ@mail.gmail.com>
 <rlgx2zq3s6vs6t26fut3ez6bix5jphvofyuw2amnbdpyb6c55m@kxzqput2rry5>
 <CANP3RGf_WoEOCgJ=X_nVBDYuwDty0BDiCSZQxONLX-dVbd2-UQ@mail.gmail.com>
 <viztnjhxjfc5asyzpxlbsjgkno7jmgs3so7xf4q4y633nncjz3@kp27s5ktxydk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <viztnjhxjfc5asyzpxlbsjgkno7jmgs3so7xf4q4y633nncjz3@kp27s5ktxydk>
X-Proofpoint-GUID: mXxFTw35hkIerPZmedFB9UTZSK-wSR_1
X-Proofpoint-ORIG-GUID: mXxFTw35hkIerPZmedFB9UTZSK-wSR_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180128

Hi All!

First, thanks for your help! This will likely be my last email on the
subject until I have something completed. I figured out how to get this
working(ish) well enough.

Introducing the Seccomp Filter Purity Test! (Attached at the end), for
preventing naughty JIT'ed code pages from mucking up your kernel (they
are not bad, persay, just naughty, since they are not acting as proper
"filters" in the standard sense of the word).

I got to thinking, and realized all we really want is for these new code
pages to not suddenly start exerting their freedom to store all sorts of
illegitimate content into different kernel regions, and that what they
decide to filter or whether their filter ends up being "dirty" since an
adversary used a write gadget to swap a comparison of one value with a
comparison of another is their own, private business, not mine.

What does matter is that if they are going to use my room in the kernel
to do all this stuff without me knowing exactly what the stuff they are
doing in their filter is, I am going to set down some baseline rules :
notably, sort of the same as a hotel room, leave the kernel the way you
got it.

I could imagine pretty easily expanding this to rerun a "version" of the
BPF verifier and ensure that any changes made to the kernel's data stay
in a confined boundary.

Here's the code. I've not tested it extensively, but it works for at
least one case (linked here https://github.com/KSPP/linux/issues/154).
Additional prescriptions are also in my comment at the link above.

Thanks again,
Maxwell Bland

// SPDX-License-Identifier: GPL-2.0-only
/*
 * Copyright (C) 2024 Motorola Mobility, Inc.
 *
 * Author: Maxwell Bland
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * Routine for verification of JIT'ed ARM64 seccomp code.
 *
 * Because of issues in determining the origin and source of seccomp filters,
 * and a lack of support for the provenance of seccomp filters, we must
 * create a special case for these allocated pages. Critically, if a page
 * does not match a known SHA256 hash, we allow the allocation of a pure
 * function matching the following restrictions:
 *
 * (1) The start can be padded by some number of BRK trap instructions matching
 * standard BPF JIT semantics.
 * (2) The prologue must match the prologue given by bpf_jit_comp.c
 * (3) The epilogue must match the epilogue given by bpf_jit_comp.c
 * (4) The body must only consist of:
 *
 * - Loads (of general purpose registers only)
 * - Arithmetic/Logical instructions (on general purpose registers only)
 * - Comparisons (on general purpose registers, because I am paranoid)
 * - Branches to immediate offsets guaranteed to be within the program
 *   (branch register is considered harmful)
 *
 * This is sufficient to guarantee that the program can be trusted to not touch
 * the rest of the kernel, though it may of course leak critical information and
 * secrets.
 */
#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>

/* TODO REMOVE BELOW --- integrate with actual kernel
 * For now this is done so that you can quickly "test it out"
 * by placing this file in arch/arm64/net/ and compiling with
 * `clang -static seccomp_jit_check_patched.c ../lib/lib.a`
 *
 * After the following easy patch:

--- a/arch/arm64/include/asm/insn-def.h
 #ifndef __ASM_INSN_DEF_H
 #define __ASM_INSN_DEF_H
 
-#include <asm/brk-imm.h>
+#include "brk-imm.h"
--- a/arch/arm64/include/asm/insn.h
 #ifndef        __ASM_INSN_H
 #define        __ASM_INSN_H
-#include <linux/build_bug.h>
 #include <linux/types.h>
 
-#include <asm/insn-def.h>
+#include "insn-def.h"
 
 #ifndef __ASSEMBLY__
 
@@ -301,7 +300,6 @@ enum aarch64_insn_mb_type {
 #define        __AARCH64_INSN_FUNCS(abbr, mask, val)                           \
 static __always_inline bool aarch64_insn_is_##abbr(u32 code)           \
 {                                                                      \
-       BUILD_BUG_ON(~(mask) & (val));                                  \
        return (code & (mask)) == (val);                                \
 }                                                                      \
 static __always_inline u32 aarch64_insn_get_##abbr##_value(void)       \
--- a/arch/arm64/net/bpf_jit.h
 #ifndef _BPF_JIT_H
 #define _BPF_JIT_H
 
-#include <asm/insn.h>

 *
 */
int _printk(const char *format, ...) {
	return 0;
}

void __sw_hweight64() {
	printf("ACKBAR!\n");
}

#define u8 uint8_t
#define u32 uint32_t
#define s32 int32_t
#define u64 uint64_t

#define A64_HINT(x) aarch64_insn_gen_hint(x)             
#define A64_NOP A64_HINT(AARCH64_INSN_HINT_NOP)
#define A64_PACIASP A64_HINT(AARCH64_INSN_HINT_PACIASP)  
#define A64_AUTIASP A64_HINT(AARCH64_INSN_HINT_AUTIASP)  
#define A64_R(x)        AARCH64_INSN_REG_##x
#define A64_FP          AARCH64_INSN_REG_FP 
#define A64_LR          AARCH64_INSN_REG_LR 
#define A64_ZR          AARCH64_INSN_REG_ZR 
#define A64_SP          AARCH64_INSN_REG_SP 

/* TODO REMOVE ABOVE */

#include "../include/asm/insn.h"
#include "bpf_jit.h"

#define PAGE_SIZE 0x1000
/* Vals may increase based on CONFIGs */
#define PROLOGUE_BASE_NUM_INSNS 11
#define EPILOGUE_BASE_NUM_INSNS 8
#define COMMON_GP_TARGET_REG_MASK 0x1F /* Common general purpose target register mask */
#define PAIR_GP_TARGET_REG_MASK 0x7C00
#define BRANCH_IMM_MASK  0x0FFFFFF
#define CBRANCH_IMM_MASK 0x0FFFFE0

int32_t sign_extend_branch_mask(uint32_t imm) {
	return ((int32_t) (imm << 8)) >> 6;
}

int32_t sign_extend_cbranch_mask(uint32_t imm) {
	return (((int32_t) (imm << 8)) >> 6) >> 5;
}

int match_padding(uint32_t insn) {
        if (insn == 0xd4202000)
                return 1;
        return 0;
}

/*
 * Effectively a copy of the semantics from build_prologue in
 * bpf_jit_comp.c: we might as well call to this function
 * directly to create an "integrity verification" buffer at boot-time and
 * then use this read-only verification buffer to guarantee
 * the contents of the prologue after JIT.
 */
int match_prologue(uint32_t page[PAGE_SIZE], uint64_t *ind) {
        const uint8_t r6 = A64_R(19);
	const uint8_t r7 = A64_R(20);
	const uint8_t r8 = A64_R(21);
	const uint8_t r9 = A64_R(22);
	const uint8_t fp = A64_R(25);
	const uint8_t tcc = A64_R(26);
	const uint8_t fpb = A64_R(27);
        uint64_t max_num_insns = PROLOGUE_BASE_NUM_INSNS;
        // if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
        //         max_num_insns++
	// if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
                max_num_insns++;

        if (*ind + max_num_insns >= PAGE_SIZE) {
		printf("Index passed PAGE_SIZE\n");
                return 0;
	}

        // if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
        //         if (page[*ind++] != (A64_BTI_JC))
        //                 return 0;

        if (page[(*ind)++] != (A64_MOV(1, A64_R(9), A64_LR))) {
		printf("page[(*ind)++] != (A64_MOV(1, A64_R(9), A64_LR) %x != %x", page[*(ind - 1)], (A64_MOV(1, A64_R(9), A64_LR)));
                return 0;
	}

        if (page[(*ind)++] != (A64_NOP)) {
		printf("page[(*ind)++] != (A64_NOP) %x != %x", page[*(ind - 1)], (A64_NOP));
                return 0;
	}

	/* Sign lr */
	// if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
                if (page[(*ind)++] != (A64_PACIASP)) {
			printf("page[(*ind)++] != (A64_PACIASP) %x != %x", page[*(ind - 1)], (A64_PACIASP));
                        return 0;
		}

	/* Save FP and LR registers to stay align with ARM64 AAPCS */
	if (page[(*ind)++] != (A64_PUSH(A64_FP, A64_LR, A64_SP))) {
		printf("page[(*ind)++] != (A64_PUSH(A64_FP, A64_LR, A64_SP) %x != %x", page[*(ind - 1)], (A64_PUSH(A64_FP, A64_LR, A64_SP)));
                return 0;
	}
	if (page[(*ind)++] != (A64_MOV(1, A64_FP, A64_SP))) {
		printf("page[(*ind)++] != (A64_MOV(1, A64_FP, A64_SP) %x != %x", page[*(ind - 1)], (A64_MOV(1, A64_FP, A64_SP)));
                return 0;
	}

	/* Save callee-saved registers */
	if (page[(*ind)++] != (A64_PUSH(r6, r7, A64_SP))) {
		printf("page[(*ind)++] != (A64_PUSH(r6, r7, A64_SP) %x != %x", page[*(ind - 1)], (A64_PUSH(r6, r7, A64_SP)));
                return 0;
	}
	if (page[(*ind)++] != (A64_PUSH(r8, r9, A64_SP))) {
		printf("page[(*ind)++] != (A64_PUSH(r8, r9, A64_SP) %x != %x", page[*(ind - 1)], (A64_PUSH(r8, r9, A64_SP)));
                return 0;
	}
	if (page[(*ind)++] != (A64_PUSH(fp, tcc, A64_SP))) {
		printf("page[(*ind)++] != (A64_PUSH(fp, tcc, A64_SP) %x != %x", page[*(ind - 1)], (A64_PUSH(fp, tcc, A64_SP)));
                return 0;
	}
	if (page[(*ind)++] != (A64_PUSH(fpb, A64_R(28), A64_SP))) {
		printf("page[(*ind)++] != (A64_PUSH(fpb, A64_R(28), A64_SP) %x != %x", page[*(ind - 1)], (A64_PUSH(fpb, A64_R(28), A64_SP)));
                return 0;
	}

	/* Set up BPF prog stack base register */
	if (page[(*ind)++] != (A64_MOV(1, fp, A64_SP))) {
		printf("page[(*ind)++] != (A64_MOV(1, fp, A64_SP) %x != %x", page[*(ind - 1)], (A64_MOV(1, fp, A64_SP)));
                return 0;
	}

        /* Program should always be ebpf_from_cpf for
         * seccomp, so ignore the tail_call_cnt and bti j initialization
         * which would normally be in the prologue at this point */

        /* Based on the semantics of find_fpb_offset, ctx->fpb_offset, used
         * to decide this next instruction, is non-zero iff there is a
         * store/load involving the frame pointer, which would be exceedingly
         * weird to have in a seccomp filter (I'd like to see a justification if
         * such a program does exist) and is therefore assumed to be 0. */
        if (page[(*ind)++] != (A64_SUB_I(1, fpb, fp, 0))) {
		printf("page[(*ind)++] != (A64_SUB_I(1, fpb, fp, 0) %x != %x", page[*(ind - 1)], (A64_SUB_I(1, fpb, fp, 0)));
                return 0;
	}

        /* Standard program semantics here only make the restriction that
         * the program stack must be a multiple of 16 bytes, but why the
         * heck is a seccomp filter using the stack? So we force it 0 as
         * well */
	if (page[(*ind)++] != (A64_SUB_I(1, A64_SP, A64_SP, 0))) {
		printf("page[(*ind)++] != (A64_SUB_I(1, A64_SP, A64_SP, 0) %x != %x", page[*(ind - 1)], (A64_SUB_I(1, A64_SP, A64_SP, 0)));
                return 0;
	}

	return 1;
}

int match_epilogue(uint32_t page[PAGE_SIZE], uint64_t *ind) {
	const uint8_t r0 = A64_R(7);
        const uint8_t r6 = A64_R(19);
	const uint8_t r7 = A64_R(20);
	const uint8_t r8 = A64_R(21);
	const uint8_t r9 = A64_R(22);
	const uint8_t fp = A64_R(25);
	const uint8_t fpb = A64_R(27);
        uint64_t max_num_insns = EPILOGUE_BASE_NUM_INSNS;
	// if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
                max_num_insns++;

        if (*ind + max_num_insns >= PAGE_SIZE) {
		printf("Epilogue past page size!\n");
                return 0;
	}

        if (page[(*ind)++] != (A64_ADD_I(1, A64_SP, A64_SP, 0))) {
		printf("page[(*ind)++] != (A64_ADD_I(1, A64_SP, A64_SP, 0) %x != %x", page[*(ind - 1)], (A64_ADD_I(1, A64_SP, A64_SP, 0)));
                return 0;
	}
                                                                 
        if (page[(*ind)++] != (A64_POP(fpb, A64_R(28), A64_SP))) {
		printf("page[(*ind)++] != (A64_POP(fpb, A64_R(28), A64_SP) %x != %x", page[*(ind - 1)], (A64_POP(fpb, A64_R(28), A64_SP)));
                return 0;
	}
        if (page[(*ind)++] != (A64_POP(fp, A64_R(26), A64_SP))) {
		printf("page[(*ind)++] != (A64_POP(fp, A64_R(26), A64_SP) %x != %x", page[*(ind - 1)], (A64_POP(fp, A64_R(26), A64_SP)));
                return 0;
	}
                                                                         
        if (page[(*ind)++] != (A64_POP(r8, r9, A64_SP)))                              {
		printf("page[(*ind)++] != (A64_POP(r8, r9, A64_SP) %x != %x", page[*(ind - 1)], (A64_POP(r8, r9, A64_SP)));
                return 0;
	}
        if (page[(*ind)++] != (A64_POP(r6, r7, A64_SP)))                              {
		printf("page[(*ind)++] != (A64_POP(r6, r7, A64_SP) %x != %x", page[*(ind - 1)], (A64_POP(r6, r7, A64_SP)));
                return 0;
	}
                                                                         
        if (page[(*ind)++] != (A64_POP(A64_FP, A64_LR, A64_SP))) {
		printf("page[(*ind)++] != (A64_POP(A64_FP, A64_LR, A64_SP) %x != %x", page[*(ind - 1)], (A64_POP(A64_FP, A64_LR, A64_SP)));
                return 0;
	}
                                                                         
        if (page[(*ind)++] != (A64_MOV(1, A64_R(0), r0))) {
		printf("page[(*ind)++] != (A64_MOV(1, A64_R(0), r0) %x != %x", page[*(ind - 1)], (A64_MOV(1, A64_R(0), r0)));
                return 0;
	}
                                                                         
         // if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))                   
                if (page[(*ind)++] != (A64_AUTIASP)) {
			printf("page[(*ind)++] != (A64_AUTIASP) %x != %x", page[*(ind - 1)], (A64_AUTIASP));
                        return 0;
		}
                                                                         
        if (page[(*ind)++] != (A64_RET(A64_LR))) {
		printf("page[(*ind)++] != (A64_RET(A64_LR) %x != %x", page[*(ind - 1)], (A64_RET(A64_LR)));
                return 0;
	}

        return 1;
}


int insn_ok(uint32_t insn) {
	printf("Entering insn_ok\n");
        // Dest is in least sig 5 bits. Note CMP* instructions
        // are implemented as subs, etc, with a special dest.
        if (aarch64_insn_is_adr(insn) ||
            aarch64_insn_is_adrp(insn) ||
            aarch64_insn_is_load_imm(insn) ||
            aarch64_insn_is_load_pre(insn) ||
            aarch64_insn_is_load_post(insn) ||
            aarch64_insn_is_ldr_reg(insn) ||
            aarch64_insn_is_ldr_imm(insn) ||
            aarch64_insn_is_ldr_lit(insn) ||
            aarch64_insn_is_ldrsw_lit(insn) ||
            aarch64_insn_is_add_imm(insn) ||
            aarch64_insn_is_adds_imm(insn) ||
            aarch64_insn_is_sub_imm(insn) ||
            aarch64_insn_is_subs_imm(insn) ||
            aarch64_insn_is_movn(insn) ||
            aarch64_insn_is_sbfm(insn) ||
            aarch64_insn_is_bfm(insn) ||
            aarch64_insn_is_movz(insn) ||
            aarch64_insn_is_ubfm(insn) ||
            aarch64_insn_is_movk(insn) ||
            aarch64_insn_is_add(insn) ||
            aarch64_insn_is_adds(insn) ||
            aarch64_insn_is_sub(insn) ||
            aarch64_insn_is_subs(insn) ||
            aarch64_insn_is_madd(insn) ||
            aarch64_insn_is_msub(insn) ||
            aarch64_insn_is_udiv(insn) ||
            aarch64_insn_is_sdiv(insn) ||
            aarch64_insn_is_lslv(insn) ||
            aarch64_insn_is_lsrv(insn) ||
            aarch64_insn_is_asrv(insn) ||
            aarch64_insn_is_rorv(insn) ||
            aarch64_insn_is_rev16(insn) ||
            aarch64_insn_is_rev32(insn) ||
            aarch64_insn_is_rev64(insn) ||
            aarch64_insn_is_and(insn) ||
            aarch64_insn_is_bic(insn) ||
            aarch64_insn_is_orr(insn) ||
            aarch64_insn_is_mov_reg(insn) ||
            aarch64_insn_is_orn(insn) ||
            aarch64_insn_is_eor(insn) ||
            aarch64_insn_is_eon(insn) ||
            aarch64_insn_is_ands(insn) ||
            aarch64_insn_is_bics(insn) ||
            aarch64_insn_is_and_imm(insn) ||
            aarch64_insn_is_orr_imm(insn) ||
            aarch64_insn_is_eor_imm(insn) ||
            aarch64_insn_is_ands_imm(insn) ||
            aarch64_insn_is_extr(insn)
        )
        {
                if ((insn & COMMON_GP_TARGET_REG_MASK) > 28) {
                        if ((insn & COMMON_GP_TARGET_REG_MASK) == 0x1f) {
				printf("Checking is cmp op type!\n");
                                /* Only allow  aliases, otherwise fail */
				if (
						aarch64_insn_is_adds(insn) ||
						aarch64_insn_is_adds_imm(insn) ||
						aarch64_insn_is_subs(insn) ||
						aarch64_insn_is_subs_imm(insn) ||
						aarch64_insn_is_ands(insn) ||
						aarch64_insn_is_ands_imm(insn)
				   ) {
					printf("Returning OK!\n");
                                        return 1;
				}
                        }
                        return 0;
                }
                return 1;
        }

        // Pair of registers
        if (
                aarch64_insn_is_ldp(insn) ||
                aarch64_insn_is_ldp_post(insn) || // post-index variant
                aarch64_insn_is_ldp_pre(insn) // pre-index variant
        )
        {
                if ((insn & PAIR_GP_TARGET_REG_MASK) > 28 ||
                    (insn & COMMON_GP_TARGET_REG_MASK) > 28)
                        return 0;
                return 1;
        }
        
        // No dest effect
        if (
                aarch64_insn_is_prfm(insn) ||
                aarch64_insn_is_prfm_lit(insn) ||
                aarch64_insn_is_dmb(insn) ||
                aarch64_insn_is_dsb_base(insn) ||
                aarch64_insn_is_dsb_nxs(insn) ||
                aarch64_insn_is_isb(insn) ||
                aarch64_insn_is_sb(insn) ||
                aarch64_insn_is_ssbb(insn) ||
                aarch64_insn_is_pssbb(insn)
        ) {
                return 1;
        }

        // Branch insn
        if (
                aarch64_insn_is_b(insn) ||
                aarch64_insn_is_cbz(insn) ||
                aarch64_insn_is_cbnz(insn) ||
                aarch64_insn_is_tbz(insn) ||
                aarch64_insn_is_tbnz(insn) ||
                aarch64_insn_is_bcond(insn)
        ) {
                /* 
                 * For now, do nothing. After we determine the
                 * size of the body, we will check each index
                 * is not outside of the expected bounds
                 */
                return 1;
        }

        return 0;
}

/*
 * branch_imms_ok - checks if any branches immediate values exceed the program length
 * @branch_imms: array storing adjacent pairs of immediate value, PC offset
 * @pairs_len: the length of this array
 * @prog_len: the size of the program in bytes
 *
 * Yes, you may still jump to arbitrary offsets in the program, but since everything
 * is "pure" you won't exactly be able to store your results.
 */
int branch_imms_ok(uint32_t branch_imms[PAGE_SIZE * 2], uint64_t pairs_len, uint64_t prog_len) {
	uint64_t i = 0;
	uint32_t pc;
	int32_t imm;
	while (i < pairs_len) {
		imm = (int32_t) branch_imms[i];
		pc = branch_imms[i + 1];
		printf("Checking branch imm %x pc %x prog_len %lx\n", imm, pc, prog_len);
		if (pc + imm > prog_len || pc + imm < 0)
			return 0;
		i += 2;
	}
	return 1;
}

int purity_check(uint32_t page[PAGE_SIZE], uint64_t *ind) {
	uint32_t branch_imms[PAGE_SIZE * 2];
	uint64_t branch_imms_ind = 0;
	uint64_t prog_start = 0;
	uint64_t prog_end = 0;

        if (!match_prologue(page, ind)) {
		printf("Failed to match prologue\n");
                return -1;
	}

	prog_start = *ind;

	/* Check instructions and record branch offset information */
        while (*ind < PAGE_SIZE) {
		printf("Checking insn %x at ind %lx\n", page[*ind], *ind);
                if (!insn_ok(page[*ind]))
                        break;
		if (aarch64_insn_is_b(page[*ind])) {
			branch_imms[branch_imms_ind++] = sign_extend_branch_mask(page[*ind] & BRANCH_IMM_MASK);
			branch_imms[branch_imms_ind++] = (*ind) - prog_start;
		} else if (aarch64_insn_is_cbz(page[*ind]) ||
			   aarch64_insn_is_cbnz(page[*ind]) ||
			   aarch64_insn_is_tbz(page[*ind]) ||
			   aarch64_insn_is_tbnz(page[*ind]) ||
			   aarch64_insn_is_bcond(page[*ind])) {
			branch_imms[branch_imms_ind++] = sign_extend_cbranch_mask(page[*ind] & CBRANCH_IMM_MASK);
			branch_imms[branch_imms_ind++] = (*ind) - prog_start;
		}
		(*ind)++;
        }
	branch_imms[branch_imms_ind] = 0;

	printf("Leaving instruction check loop\n");

	prog_end = (*ind) - 1;

        if (!match_epilogue(page, ind)) {
		printf("Invalid epilogue!\n");
                return 0;
	}


	if (!branch_imms_ok(branch_imms, branch_imms_ind, (prog_end - prog_start) * sizeof(uint32_t))) {
		printf("Invalid Branch Immediate Offset Value!\n");
		return 0;
	}

        return 1;
}

int main(int argc, char **argv) {
        FILE * inp = freopen(NULL, "rb", stdin);
        uint32_t page[PAGE_SIZE];
        uint32_t insn = 0;
        uint64_t sz = 0;
        uint64_t ind = 0;

        while ((sz = fread(&insn, sizeof(insn), 1, inp))) {
                if (ind >= PAGE_SIZE)
                        return -1; /* Nah, we don't play like that */
                page[ind++] = insn;
        }

        ind = 0;
        while (ind < PAGE_SIZE) { 
                if (!match_padding(page[ind]))
                    break;
		ind++;
        }

        if (ind == PAGE_SIZE) {
		printf("Ind == PAGE_SIZE\n");
                return -1;
	}

        if (!purity_check(page, &ind)) {
		printf("Failed purity check\n");
                return -1;
	}

	printf("Passed purity check\n");
        return 0;
}


