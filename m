Return-Path: <linux-integrity+bounces-8373-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFmtHuTmfGlTPQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8373-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 18:14:12 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A2BCE61
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 18:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E3330EB395
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B1356A07;
	Fri, 30 Jan 2026 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SSF9ORLE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117F346AF8
	for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792786; cv=none; b=TXE9KyAuCAr5+fYlTFc8Wt2R1AZQzxXgLu78STzCAmADVxdFjrwa89HYVxYXEuw8zfcCCqA/fOZu6gtz+HtsEs64+T/6Vw2xIxIlFILmRO2gnKSsSohv5j9tzPjHbMuGg40voHbK1DtxFu+jwvkQ62FbtPriYY4UQjOdReVvD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792786; c=relaxed/simple;
	bh=6eGx7thqmXNsLRiHasYWnYmpkXHF30rS9/OlVSvNRNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERGpnVmkXDE5Myv0Ecg6goWopPqjIJA37f3EXfsZzK4caImI5IZhiOfgQZMf6W60AaxXWAOyEmOXjeZGaDJETdlKqT8PyibsByJQlMM3vQlKNRx8j01ZGuJcqQS/spVKzasyrzfni4t6LhZMGVwoTQnRPLf4nwHxtcEdWhn3b/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SSF9ORLE; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso20120125e9.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769792782; x=1770397582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMJORWzmOlpEqP661qXUzTKVdV68wRwU7CbPE5NG1tY=;
        b=SSF9ORLEeS06OjDUW8CWpftbqObC+3i5y68oiq9hZxBi2zR4khKzSmFgBzK/+NXqPV
         tO+36o6ybPIhvx8kQXyZutq57cvh8N8pO+z3wFXGyP/p4nPffPGbCXUrnTXQbhFXRnnS
         ukKeZ2eweNGDbOJGtZDxc4293AaQ0mMP6FymQJ7p4td5o/i+Y0JGLq6VYstWxJDFsWyf
         Ah8/U/5kKdsI7GsJiRa6UhdU0oNh80Exn2ymerdF/egb5v+7p9kP4sdpfbvU5GmfoN0X
         zP+TSjoOJa/KRquTHi1EK3jj2GGQGmmn4qiMJCGLMSUii8Zc8VF6NBIFFHTSL9It15vP
         oNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792782; x=1770397582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMJORWzmOlpEqP661qXUzTKVdV68wRwU7CbPE5NG1tY=;
        b=c0IQHUA78e5kbrGP0V6vGD7pqX5rH2pDEO3TkUEfFT6aWX72/8Be8VIFeVZtppvKXL
         PSTmfFDRVxmfk0O1I41w6VdFVBcopNwxBQqIHEEV1QwYbUe1jdl0WJIAhVb2lS/t2Zrb
         +9OtviKtL0iwEtlcBzR7j3y7QQTzNpCZSbC2FQsnI0gZObPkMZ9jTSVAPWkPLTxlP7bD
         UnOSdtgTASHHUOlFKOW/4E3uDEFixfC9zxR7uiw/sgfwjYsk/U+hPoevq2JubZH5t1q1
         xrY795wGYm55nWSuVrfpFjhnk29C3HE7imf38rw/cD3ZsF1gqaf2UApWAqMQS5m5/R9M
         QJhg==
X-Forwarded-Encrypted: i=1; AJvYcCUdEsimFSqgEXjexpnB0tcYqN5o2spvB+5hwx2R1YpOjY6o04o7SQUmOApJE+6hSlHQ4/+8EXj5+cisY30pp7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIn+zViGsBzf6wK4UhzqjeL1dGFyXQG461DtHwNtHs4Rvc6hG
	pFpTrLLukjDq7Mt/a0evo2C+lp5uW/i330Wg8j+kITJFwB4Zy2iWOOnWj1Vw9PmNNNU=
X-Gm-Gg: AZuq6aJU9y7GHwO44xiDgb+3RBKhXw6kHHNtmsSj6ONI4ELzlAq+dvya8+DrX8CJHq8
	9iJjL/bOflYx0lrr1goAAES8u6KzQxjaSPW8r0Gg4zWr+bA67qP595lPNCYj0nneBzietBw5SVU
	a1VQ7Im7nIwHbmWx5KXZs7CdUqnpcINHVMdtI4oPH4z9QI5c83S47gXVH86e4TIddnB264BUkcS
	7wUMesUhUb1e4tJLF65K/kTtcIi9cydhRdflYifRrRmFCpydTE5a8lrzHukTVbQQGcNBccjFAwi
	WHZ0UOvftPoUqbhu352OxVyXoUmDWpcDVXcTbZTTbNX9u3glJCSPLVopluSHA55q6E0TMHQJS8f
	SlbMkSd7psGTUciK3g3YrE7Ze2R8EoTj05aQ2JzKyXSD2MtGyICRWyCyFqiB3BYMFJzBIiO8T2n
	oUtw4tVYWh31alRy1nsg3gMdQV7AxkSQ==
X-Received: by 2002:a05:600c:1385:b0:480:4d76:daf0 with SMTP id 5b1f17b1804b1-482db49e8b9mr41644875e9.37.1769792782094;
        Fri, 30 Jan 2026 09:06:22 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e047d863sm21561025e9.1.2026.01.30.09.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:06:21 -0800 (PST)
Message-ID: <db1ed045-d7b6-49dc-b111-9fea7c30f8ab@suse.com>
Date: Fri, 30 Jan 2026 18:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-8373-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnu.org:url,o.map:url,vmlinux.map:url,system.map:url,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: CB3A2BCE61
X-Rspamd-Action: no action

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> Normally the .ko module files depend on a fully built vmlinux to be
> available for modpost validation and BTF generation. With
> CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> to build a merkle tree. This introduces a dependency cycle which is
> impossible to satisfy. Work around this by building the modules during
> link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> but before the final module hashes are

I wonder if this dependency cycle could be resolved by utilizing the
split into vmlinux.unstripped and vmlinux that occurred last year.

The idea is to create the following ordering: vmlinux.unstripped ->
modules -> vmlinux, and to patch in .module_hashes only when building
the final vmlinux.

This would require the following:
* Split scripts/Makefile.vmlinux into two Makefiles, one that builds the
  current vmlinux.unstripped and the second one that builds the final
  vmlinux from it.
* Modify the top Makefile to recognize vmlinux.unstripped and update the
  BTF generation rule 'modules: vmlinux' to
  'modules: vmlinux.unstripped'.
* Add the 'vmlinux: modules' ordering in the top Makefile for
  CONFIG_MODULE_HASHES=y.
* Remove the patching of vmlinux.unstripped in scripts/link-vmlinux.sh
  and instead move it into scripts/Makefile.vmlinux when running objcopy
  to produce the final vmlinux.

I think this approach has two main advantages:
* CONFIG_MODULE_HASHES can be made orthogonal to
  CONFIG_DEBUG_INFO_BTF_MODULES.
* All dependencies are expressed at the Makefile level instead of having
  scripts/link-vmlinux.sh invoke 'make -f Makefile modules'.

Below is a rough prototype that applies on top of this series. It is a
bit verbose due to the splitting of part of scripts/Makefile.vmlinux
into scripts/Makefile.vmlinux_unstripped.

-- 
Thanks,
Petr


diff --git a/Makefile b/Makefile
index 841772a5a260..19a3beb82fa7 100644
--- a/Makefile
+++ b/Makefile
@@ -1259,7 +1259,7 @@ vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
 vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
 	@:
 
-PHONY += vmlinux
+PHONY += vmlinux.unstripped vmlinux
 # LDFLAGS_vmlinux in the top Makefile defines linker flags for the top vmlinux,
 # not for decompressors. LDFLAGS_vmlinux in arch/*/boot/compressed/Makefile is
 # unrelated; the decompressors just happen to have the same base name,
@@ -1270,9 +1270,11 @@ PHONY += vmlinux
 #   https://savannah.gnu.org/bugs/?61463
 # For Make > 4.4, the following simple code will work:
 #  vmlinux: private export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
-vmlinux: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
-vmlinux: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
-vmlinux: vmlinux.o $(KBUILD_LDS) modpost
+vmlinux.unstripped: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
+vmlinux.unstripped: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
+vmlinux.unstripped: vmlinux.o $(KBUILD_LDS) modpost
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_unstripped
+vmlinux: vmlinux.unstripped
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
 
 # The actual objects are generated when descending,
@@ -1541,7 +1543,7 @@ all: dtbs
 endif
 
 ifdef CONFIG_GENERIC_BUILTIN_DTB
-vmlinux: dtbs
+vmlinux.unstripped: dtbs
 endif
 
 endif
@@ -1588,9 +1590,11 @@ endif
 # is an exception.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 KBUILD_BUILTIN := y
-ifndef CONFIG_MODULE_HASHES
-modules: vmlinux
+modules: vmlinux.unstripped
 endif
+
+ifdef CONFIG_MODULE_HASHES
+vmlinux: modules
 endif
 
 modules: modules_prepare
@@ -1983,11 +1987,7 @@ modules.order: $(build-dir)
 # KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
 # This is solely useful to speed up test compiles.
 modules: modpost
-ifdef CONFIG_MODULE_HASHES
-ifeq ($(MODULE_HASHES_MODPOST_FINAL), 1)
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
-endif
-else ifneq ($(KBUILD_MODPOST_NOFINAL),1)
+ifneq ($(KBUILD_MODPOST_NOFINAL),1)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
 endif
 
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 890724edac69..213e21ecfe0d 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -55,7 +55,7 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	$(cmd);                                                              \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
-# Re-generate module BTFs if either module's .ko or vmlinux changed
+# Re-generate module BTFs if either module's .ko or vmlinux.unstripped changed
 %.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/.tmp_vmlinux_btf.stamp) FORCE
 	+$(call if_changed_except,ld_ko_o,$(objtree)/.tmp_vmlinux_btf.stamp)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 4ce849f6253a..8c2a938c88ab 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -15,78 +15,24 @@ targets :=
 %.o: %.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-# Built-in dtb
-# ---------------------------------------------------------------------------
-
-quiet_cmd_wrap_dtbs = WRAP    $@
-      cmd_wrap_dtbs = {							\
-	echo '\#include <asm-generic/vmlinux.lds.h>';			\
-	echo '.section .dtb.init.rodata,"a"';				\
-	while read dtb; do						\
-		symbase=__dtb_$$(basename -s .dtb "$${dtb}" | tr - _);	\
-		echo '.balign STRUCT_ALIGNMENT';			\
-		echo ".global $${symbase}_begin";			\
-		echo "$${symbase}_begin:";				\
-		echo '.incbin "'$$dtb'" ';				\
-		echo ".global $${symbase}_end";				\
-		echo "$${symbase}_end:";				\
-	done < $<;							\
-	} > $@
-
-.builtin-dtbs.S: .builtin-dtbs-list FORCE
-	$(call if_changed,wrap_dtbs)
-
-quiet_cmd_gen_dtbs_list = GEN     $@
-      cmd_gen_dtbs_list = \
-	$(if $(CONFIG_BUILTIN_DTB_NAME), echo "arch/$(SRCARCH)/boot/dts/$(CONFIG_BUILTIN_DTB_NAME).dtb",:) > $@
-
-.builtin-dtbs-list: arch/$(SRCARCH)/boot/dts/dtbs-list FORCE
-	$(call if_changed,$(if $(CONFIG_BUILTIN_DTB_ALL),copy,gen_dtbs_list))
-
-targets += .builtin-dtbs-list
-
-ifdef CONFIG_GENERIC_BUILTIN_DTB
-targets += .builtin-dtbs.S .builtin-dtbs.o
-vmlinux.unstripped: .builtin-dtbs.o
-endif
-
-# vmlinux.unstripped
+# vmlinux
 # ---------------------------------------------------------------------------
 
-ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
-vmlinux.unstripped: arch/$(SRCARCH)/tools/vmlinux.arch.o
-
-arch/$(SRCARCH)/tools/vmlinux.arch.o: vmlinux.o FORCE
-	$(Q)$(MAKE) $(build)=arch/$(SRCARCH)/tools $@
-endif
-
-ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
-
-# Final link of vmlinux with optional arch pass after final link
-cmd_link_vmlinux =							\
-	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)" "$@";	\
-	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+ifdef CONFIG_MODULE_HASHES
+targets += .tmp_module_hashes.o
+.tmp_module_hashes.o: .tmp_module_hashes.c FORCE
 
-targets += vmlinux.unstripped .vmlinux.export.o
-vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o $(KBUILD_LDS) FORCE
-	+$(call if_changed_dep,link_vmlinux)
-ifdef CONFIG_DEBUG_INFO_BTF
-vmlinux.unstripped: $(RESOLVE_BTFIDS)
-endif
+quiet_cmd_module_hashes = OBJCOPY $@
+      cmd_module_hashes = $(OBJCOPY) --dump-section .module_hashes=$@ $<
 
-ifdef CONFIG_BUILDTIME_TABLE_SORT
-vmlinux.unstripped: scripts/sorttable
-endif
+targets += .tmp_module_hashes.bin
+.tmp_module_hashes.bin: .tmp_module_hashes.o FORCE
+	$(call if_changed,module_hashes)
 
-ifdef CONFIG_MODULE_HASHES
-vmlinux.unstripped: $(objtree)/scripts/modules-merkle-tree
-vmlinux.unstripped: modules.order
-vmlinux.unstripped: $(wildcard include/config/MODULE_INSTALL_STRIP)
+vmlinux: .tmp_module_hashes.bin
+patch-module-hashes := --update-section .module_hashes=.tmp_module_hashes.bin
 endif
 
-# vmlinux
-# ---------------------------------------------------------------------------
-
 remove-section-y                                   := .modinfo
 remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '!.rel*.dyn'
 # for compatibility with binutils < 2.32
@@ -98,70 +44,15 @@ remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
 # To avoid warnings: "empty loadable segment detected at ..." from GNU objcopy,
 # it is necessary to remove the PT_LOAD flag from the segment.
 quiet_cmd_strip_relocs = OBJCOPY $@
-      cmd_strip_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
-                         $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
+      cmd_script_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
+                          $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) \
+                                     $(remove-symbols) \
+                                     $(patch-module-hashes) $@
 
 targets += vmlinux
 vmlinux: vmlinux.unstripped FORCE
 	$(call if_changed,strip_relocs)
 
-# modules.builtin.modinfo
-# ---------------------------------------------------------------------------
-
-# .modinfo in vmlinux.unstripped is aligned to 8 bytes for compatibility with
-# tools that expect vmlinux to have sufficiently aligned sections but the
-# additional bytes used for padding .modinfo to satisfy this requirement break
-# certain versions of kmod with
-#
-#   depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix
-#
-# Strip the trailing padding bytes after extracting .modinfo to comply with
-# what kmod expects to parse.
-quiet_cmd_modules_builtin_modinfo = GEN     $@
-      cmd_modules_builtin_modinfo = $(cmd_objcopy); \
-                                    sed -i 's/\x00\+$$/\x00/g' $@
-
-OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
-
-targets += modules.builtin.modinfo
-modules.builtin.modinfo: vmlinux.unstripped FORCE
-	$(call if_changed,modules_builtin_modinfo)
-
-# modules.builtin
-# ---------------------------------------------------------------------------
-
-__default: modules.builtin
-
-# The second line aids cases where multiple modules share the same object.
-
-quiet_cmd_modules_builtin = GEN     $@
-      cmd_modules_builtin = \
-	tr '\0' '\n' < $< | \
-	sed -n 's/^[[:alnum:]:_]*\.file=//p' | \
-	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$$/.ko/' > $@
-
-targets += modules.builtin
-modules.builtin: modules.builtin.modinfo FORCE
-	$(call if_changed,modules_builtin)
-
-# modules.builtin.ranges
-# ---------------------------------------------------------------------------
-ifdef CONFIG_BUILTIN_MODULE_RANGES
-__default: modules.builtin.ranges
-
-quiet_cmd_modules_builtin_ranges = GEN     $@
-      cmd_modules_builtin_ranges = gawk -f $(real-prereqs) > $@
-
-targets += modules.builtin.ranges
-modules.builtin.ranges: $(srctree)/scripts/generate_builtin_ranges.awk \
-			modules.builtin vmlinux.map vmlinux.o.map FORCE
-	$(call if_changed,modules_builtin_ranges)
-
-vmlinux.map: vmlinux.unstripped
-	@:
-
-endif
-
 # Add FORCE to the prerequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile.vmlinux_unstripped b/scripts/Makefile.vmlinux_unstripped
new file mode 100644
index 000000000000..914ee6f3b935
--- /dev/null
+++ b/scripts/Makefile.vmlinux_unstripped
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+PHONY := __default
+__default: vmlinux.unstripped
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Makefile.lib
+
+targets :=
+
+%.o: %.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+%.o: %.S FORCE
+	$(call if_changed_rule,as_o_S)
+
+# Built-in dtb
+# ---------------------------------------------------------------------------
+
+quiet_cmd_wrap_dtbs = WRAP    $@
+      cmd_wrap_dtbs = {							\
+	echo '\#include <asm-generic/vmlinux.lds.h>';			\
+	echo '.section .dtb.init.rodata,"a"';				\
+	while read dtb; do						\
+		symbase=__dtb_$$(basename -s .dtb "$${dtb}" | tr - _);	\
+		echo '.balign STRUCT_ALIGNMENT';			\
+		echo ".global $${symbase}_begin";			\
+		echo "$${symbase}_begin:";				\
+		echo '.incbin "'$$dtb'" ';				\
+		echo ".global $${symbase}_end";				\
+		echo "$${symbase}_end:";				\
+	done < $<;							\
+	} > $@
+
+.builtin-dtbs.S: .builtin-dtbs-list FORCE
+	$(call if_changed,wrap_dtbs)
+
+quiet_cmd_gen_dtbs_list = GEN     $@
+      cmd_gen_dtbs_list = \
+	$(if $(CONFIG_BUILTIN_DTB_NAME), echo "arch/$(SRCARCH)/boot/dts/$(CONFIG_BUILTIN_DTB_NAME).dtb",:) > $@
+
+.builtin-dtbs-list: arch/$(SRCARCH)/boot/dts/dtbs-list FORCE
+	$(call if_changed,$(if $(CONFIG_BUILTIN_DTB_ALL),copy,gen_dtbs_list))
+
+targets += .builtin-dtbs-list
+
+ifdef CONFIG_GENERIC_BUILTIN_DTB
+targets += .builtin-dtbs.S .builtin-dtbs.o
+vmlinux.unstripped: .builtin-dtbs.o
+endif
+
+# vmlinux.unstripped
+# ---------------------------------------------------------------------------
+
+ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
+vmlinux.unstripped: arch/$(SRCARCH)/tools/vmlinux.arch.o
+
+arch/$(SRCARCH)/tools/vmlinux.arch.o: vmlinux.o FORCE
+	$(Q)$(MAKE) $(build)=arch/$(SRCARCH)/tools $@
+endif
+
+ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
+
+# Final link of vmlinux with optional arch pass after final link
+cmd_link_vmlinux =							\
+	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)" "$@";	\
+	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+
+targets += vmlinux.unstripped .vmlinux.export.o
+vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o $(KBUILD_LDS) FORCE
+	+$(call if_changed_dep,link_vmlinux)
+ifdef CONFIG_DEBUG_INFO_BTF
+vmlinux.unstripped: $(RESOLVE_BTFIDS)
+endif
+
+ifdef CONFIG_BUILDTIME_TABLE_SORT
+vmlinux.unstripped: scripts/sorttable
+endif
+
+ifdef CONFIG_MODULE_HASHES
+vmlinux.unstripped: $(objtree)/scripts/modules-merkle-tree
+vmlinux.unstripped: modules.order
+vmlinux.unstripped: $(wildcard include/config/MODULE_INSTALL_STRIP)
+endif
+
+# modules.builtin.modinfo
+# ---------------------------------------------------------------------------
+
+# .modinfo in vmlinux.unstripped is aligned to 8 bytes for compatibility with
+# tools that expect vmlinux to have sufficiently aligned sections but the
+# additional bytes used for padding .modinfo to satisfy this requirement break
+# certain versions of kmod with
+#
+#   depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix
+#
+# Strip the trailing padding bytes after extracting .modinfo to comply with
+# what kmod expects to parse.
+quiet_cmd_modules_builtin_modinfo = GEN     $@
+      cmd_modules_builtin_modinfo = $(cmd_objcopy); \
+                                    sed -i 's/\x00\+$$/\x00/g' $@
+
+OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
+
+targets += modules.builtin.modinfo
+modules.builtin.modinfo: vmlinux.unstripped FORCE
+	$(call if_changed,modules_builtin_modinfo)
+
+# modules.builtin
+# ---------------------------------------------------------------------------
+
+__default: modules.builtin
+
+# The second line aids cases where multiple modules share the same object.
+
+quiet_cmd_modules_builtin = GEN     $@
+      cmd_modules_builtin = \
+	tr '\0' '\n' < $< | \
+	sed -n 's/^[[:alnum:]:_]*\.file=//p' | \
+	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$$/.ko/' > $@
+
+targets += modules.builtin
+modules.builtin: modules.builtin.modinfo FORCE
+	$(call if_changed,modules_builtin)
+
+# modules.builtin.ranges
+# ---------------------------------------------------------------------------
+ifdef CONFIG_BUILTIN_MODULE_RANGES
+__default: modules.builtin.ranges
+
+quiet_cmd_modules_builtin_ranges = GEN     $@
+      cmd_modules_builtin_ranges = gawk -f $(real-prereqs) > $@
+
+targets += modules.builtin.ranges
+modules.builtin.ranges: $(srctree)/scripts/generate_builtin_ranges.awk \
+			modules.builtin vmlinux.map vmlinux.o.map FORCE
+	$(call if_changed,modules_builtin_ranges)
+
+vmlinux.map: vmlinux.unstripped
+	@:
+
+endif
+
+# Add FORCE to the prerequisites of a target to force it to be always rebuilt.
+# ---------------------------------------------------------------------------
+
+PHONY += FORCE
+FORCE:
+
+# Read all saved command lines and dependencies for the $(targets) we
+# may be building above, using $(if_changed{,_dep}). As an
+# optimization, we don't need to read them if the target does not
+# exist, we will rebuild anyway in that case.
+
+existing-targets := $(wildcard $(sort $(targets)))
+
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
+
+.PHONY: $(PHONY)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index bfeff1f5753d..80cb09707426 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -316,17 +316,6 @@ if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
 	fi
 fi
 
-if is_enabled CONFIG_MODULE_HASHES; then
-	info MAKE modules
-	${MAKE} -f Makefile MODULE_HASHES_MODPOST_FINAL=1 modules
-	module_hashes_o=.tmp_module_hashes.o
-	info CC ${module_hashes_o}
-	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} \
-		${KBUILD_CFLAGS_KERNEL} -fno-lto -c -o "${module_hashes_o}" ".tmp_module_hashes.c"
-	${OBJCOPY} --dump-section .module_hashes=.tmp_module_hashes.bin ${module_hashes_o}
-	${OBJCOPY} --update-section .module_hashes=.tmp_module_hashes.bin ${VMLINUX}
-fi
-
 # step a (see comment above)
 if is_enabled CONFIG_KALLSYMS; then
 	if ! cmp -s System.map "${kallsyms_sysmap}"; then

