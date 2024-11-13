Return-Path: <linux-integrity+bounces-4105-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABAD9C76C3
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 16:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45ED11F23AE5
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82554277;
	Wed, 13 Nov 2024 15:23:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968D33FE
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511388; cv=pass; b=ldJY4ZNo5xNDHv5N2kEixaC94/hVM/0T7D7402+drrgRF+ewvVLTLuyaWSEzU3nfjfv0m3cTUn3XoaIorrwW7aovX5J8ywNoUEOQ+1YZkrh7D8i6iBnuGuBFBIhbpl1jLPJST9A9zvJ8NUGSPfIOKHSPpol7fYXDEr1cVyC5HRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511388; c=relaxed/simple;
	bh=KythBmWATrMg9xVztIMYYWHGkNBvdPF8owEjvuTqd4E=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=VsoPyQ0P9CnDW0oVSAicZ9Y82kR1EN97RbDdmRTkJj+VLjbQyQ6wxc1LkwXZG9K2yGnZ7+OfSVdU18rt09yA51EGwkQkKC3aeKAN0yqukAOrT0uaWQVIH5fJ/U9Vyn2s6wbOQX6ztkX4RHMWVufMJpVTYJiwDZECBx7BXN5skbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 634A3943C38
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 14:44:59 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-109-10-188.trex-nlb.outbound.svc.cluster.local [100.109.10.188])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 86DD8943A88
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 14:44:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731509098; a=rsa-sha256;
	cv=none;
	b=Jaa74Z0ifCa2D1P9N/bKXMwmAfAW1PcSF85tDuFYuWii4vmQkyR30AZjKSbdQd7j9fuQYN
	I/28+h8wpQPP+UWZFXOU4b3AxW/XwT5/pTqA7PgA2UHluF7CsyIGIarOIu1tUdSNq1nuOl
	7W6q7csvBQ7LAX17P0ITSTNh7eMvCjcSq0uCyqpX0ds1qGSQZSLUYOfhGHpMUibRDEC4J5
	UXh6N+RfV8tCrL3DUpdZRKG9oaawZuB/w/jMTtpzcoPO0TOd03t1LkQpiHvsMfk4eIgKmj
	sqERe3txCcifXk8ePa3ojXL3XohX1mDJreGOxAUntNO1GNrVRK54qTm+lXDDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731509098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cSGz+4Tu+F4DB8eDKdmUsFl9Dm2rmzPfII8+UKRLLSE=;
	b=TMinjgxVQeei3YBC4QgP7D187MvZ2zdtg76qA713G0WdB4JFlkawwGRYYNjv4pY8fiIukr
	5EH1WZNMgYuxFv43na0XYjz3ZAN3+r6vRrRs85wqrwAkKRS0qedmg4CCIUQrEYGUCQx4tm
	Ow/OUq7eUrz4WjyVKQwTIAFDE8p+1qla68sDsGq2fFnv/ca1szp8n7AO45ITB6rY0HLVtY
	qWEPqpjdcHm26zcqS9OHZp/ekIIm+ar7Ty5t7dZT39mNJnP3hf72k/zJcFgKFwmjU8Ta5+
	2LNKER3tDMHdzpf+4Ty2dJEZ2drm4QzgMf8vOb0ibCra5ZdoEYTGD/w131KBOg==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-9hbnn;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Company-Spicy: 2f4dffdb0f40ebb9_1731509099187_2906232300
X-MC-Loop-Signature: 1731509099187:2156783311
X-MC-Ingress-Time: 1731509099186
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.10.188 (trex/7.0.2);
	Wed, 13 Nov 2024 14:44:59 +0000
Received: from dhcp-138-246-3-106.dynamic.eduroam.mwn.de ([138.246.3.106]:56806 helo=[10.183.178.171])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tBEc6-00000007lEa-0ge6
	for linux-integrity@vger.kernel.org;
	Wed, 13 Nov 2024 14:44:56 +0000
Message-ID: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
Subject: regression: kernel log "flooded" with tpm tpm0: A TPM error (2306)
 occurred attempting to create NULL primary
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-integrity@vger.kernel.org
Date: Wed, 13 Nov 2024 15:44:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

Forwarding myself from:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1087331

Since 6.11.7 (might have also happened with .6, which I've skipped, but
wasn't the case at least in 6.11.5).

I get:
Nov 11 17:50:20 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 11 17:50:30 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 11 17:50:41 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 11 17:50:51 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 11 17:51:01 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 11 17:51:11 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary

every 10s.

It seems that this doesn't occur on a fresh boot, but only when I
resume from hibernation:

Nov 13 12:32:31 heisenberg kernel: Filesystems sync: 0.007 seconds
Nov 13 12:32:31 heisenberg kernel: Freezing user space processes
Nov 13 12:32:31 heisenberg kernel: sh (31294): drop_caches: 1
Nov 13 12:32:31 heisenberg kernel: Freezing user space processes completed =
(elapsed 0.326 seconds)
Nov 13 12:32:31 heisenberg kernel: OOM killer disabled.
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Marking nosave pages: [=
mem 0x00000000-0x00000fff]
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Marking nosave pages: [=
mem 0x000a0000-0x000fffff]
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Marking nosave pages: [=
mem 0x2f2a9000-0x310a8fff]
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Marking nosave pages: [=
mem 0x310be000-0x310befff]
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Marking nosave pages: [=
mem 0x34f53000-0x35046fff]
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Marking nosave pages: [=
mem 0x39cbf000-0x43afefff]
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Marking nosave pages: [=
mem 0x43b00000-0xffffffff]
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Basic memory bitmaps cr=
eated
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Preallocating image mem=
ory
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Allocated 3676637 pages=
 for snapshot
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Allocated 14706548 kbyt=
es in 1.90 seconds (7740.28 MB/s)
Nov 13 12:32:31 heisenberg kernel: Freezing remaining freezable tasks
Nov 13 12:32:31 heisenberg kernel: Freezing remaining freezable tasks compl=
eted (elapsed 0.001 seconds)
Nov 13 12:32:31 heisenberg kernel: printk: Suspending console(s) (use no_co=
nsole_suspend to debug)
Nov 13 12:32:31 heisenberg kernel: intel-hid INTC1070:00: failed to get but=
ton capability
Nov 13 12:32:31 heisenberg kernel: ACPI: EC: interrupt blocked
Nov 13 12:32:31 heisenberg kernel: Disabling non-boot CPUs ...
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 15 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 14 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 13 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 12 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 11 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 10 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 9 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 8 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 7 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 6 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 5 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 4 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 3 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 2 is now offline
Nov 13 12:32:31 heisenberg kernel: smpboot: CPU 1 is now offline
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Creating image:
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Need to copy 3608962 pa=
ges
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Normal pages needed: 36=
08962 + 1024, available pages: 13065600
Nov 13 12:32:31 heisenberg kernel: Enabling non-boot CPUs ...
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 1 APIC=
 0x1
Nov 13 12:32:31 heisenberg kernel: CPU1 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 2 APIC=
 0x8
Nov 13 12:32:31 heisenberg kernel: CPU2 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 3 APIC=
 0x9
Nov 13 12:32:31 heisenberg kernel: CPU3 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 4 APIC=
 0x10
Nov 13 12:32:31 heisenberg kernel: CPU4 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 5 APIC=
 0x11
Nov 13 12:32:31 heisenberg kernel: CPU5 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 6 APIC=
 0x18
Nov 13 12:32:31 heisenberg kernel: CPU6 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 7 APIC=
 0x19
Nov 13 12:32:31 heisenberg kernel: CPU7 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 8 APIC=
 0x20
Nov 13 12:32:31 heisenberg kernel: core: cpu_atom PMU driver: PEBS-via-PT=
=20
Nov 13 12:32:31 heisenberg kernel: ... version:                5
Nov 13 12:32:31 heisenberg kernel: ... bit width:              48
Nov 13 12:32:31 heisenberg kernel: ... generic registers:      6
Nov 13 12:32:31 heisenberg kernel: ... value mask:             0000ffffffff=
ffff
Nov 13 12:32:31 heisenberg kernel: ... max period:             00007fffffff=
ffff
Nov 13 12:32:31 heisenberg kernel: ... fixed-purpose events:   3
Nov 13 12:32:31 heisenberg kernel: ... event mask:             000000070000=
003f
Nov 13 12:32:31 heisenberg kernel: CPU8 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 9 APIC=
 0x22
Nov 13 12:32:31 heisenberg kernel: CPU9 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 10 API=
C 0x24
Nov 13 12:32:31 heisenberg kernel: CPU10 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 11 API=
C 0x26
Nov 13 12:32:31 heisenberg kernel: CPU11 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 12 API=
C 0x28
Nov 13 12:32:31 heisenberg kernel: CPU12 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 13 API=
C 0x2a
Nov 13 12:32:31 heisenberg kernel: CPU13 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 14 API=
C 0x2c
Nov 13 12:32:31 heisenberg kernel: CPU14 is up
Nov 13 12:32:31 heisenberg kernel: smpboot: Booting Node 0 Processor 15 API=
C 0x2e
Nov 13 12:32:31 heisenberg kernel: CPU15 is up
Nov 13 12:32:31 heisenberg kernel: ACPI: EC: interrupt unblocked
Nov 13 12:32:31 heisenberg kernel: usb usb1: root hub lost power or was res=
et
Nov 13 12:32:31 heisenberg kernel: usb usb2: root hub lost power or was res=
et
Nov 13 12:32:31 heisenberg kernel: intel-hid INTC1070:00: failed to get but=
ton capability
Nov 13 12:32:31 heisenberg kernel: usb usb3: root hub lost power or was res=
et
Nov 13 12:32:31 heisenberg kernel: usb usb4: root hub lost power or was res=
et
Nov 13 12:32:31 heisenberg kernel: i915 0000:00:02.0: [drm] GT0: GuC firmwa=
re i915/adlp_guc_70.bin version 70.29.2
Nov 13 12:32:31 heisenberg kernel: i915 0000:00:02.0: [drm] GT0: HuC firmwa=
re i915/tgl_huc.bin version 7.9.3
Nov 13 12:32:31 heisenberg kernel: nvme nvme0: D3 entry latency set to 10 s=
econds
Nov 13 12:32:31 heisenberg kernel: nvme nvme0: 16/0/0 default/read/poll que=
ues
Nov 13 12:32:31 heisenberg kernel: i915 0000:00:02.0: [drm] GT0: HuC: authe=
nticated for all workloads
Nov 13 12:32:31 heisenberg kernel: i915 0000:00:02.0: [drm] GT0: GUC: submi=
ssion enabled
Nov 13 12:32:31 heisenberg kernel: i915 0000:00:02.0: [drm] GT0: GUC: SLPC =
enabled
Nov 13 12:32:31 heisenberg kernel: i915 0000:00:02.0: [drm] GT0: GUC: RC en=
abled
Nov 13 12:32:31 heisenberg kernel: iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIF=
ICATION: 0x20
Nov 13 12:32:31 heisenberg kernel: iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTI=
FICATION: 0x1f
Nov 13 12:32:31 heisenberg kernel: iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0=
x90
Nov 13 12:32:31 heisenberg kernel: iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_=
DW9: 0x0
Nov 13 12:32:31 heisenberg kernel: iwlwifi 0000:00:14.3: RFIm is deactivate=
d, reason =3D 4
Nov 13 12:32:31 heisenberg kernel: usb 1-10: reset full-speed USB device nu=
mber 6 using xhci_hcd
Nov 13 12:32:31 heisenberg kernel: usb 1-6: reset high-speed USB device num=
ber 3 using xhci_hcd
Nov 13 12:32:31 heisenberg kernel: usb 1-5: reset high-speed USB device num=
ber 2 using xhci_hcd
Nov 13 12:32:31 heisenberg kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: IM=
R restore failed, trying to cold boot
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: Basic memory bitmaps fr=
eed
Nov 13 12:32:31 heisenberg kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2=
-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
Nov 13 12:32:31 heisenberg kernel: OOM killer enabled.
Nov 13 12:32:31 heisenberg kernel: Restarting tasks ...=20
Nov 13 12:32:31 heisenberg kernel: mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-=
a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915=
])
Nov 13 12:32:31 heisenberg kernel: done.
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: USB disconnect, device number=
 4
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: new full-speed USB device num=
ber 7 using xhci_hcd
Nov 13 12:32:31 heisenberg kernel: PM: hibernation: hibernation exit
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: New USB device found, idVendo=
r=3D058f, idProduct=3D9540, bcdDevice=3D 1.20
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: New USB device strings: Mfr=
=3D1, Product=3D2, SerialNumber=3D0
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: Product: EMV Smartcard Reader
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: Manufacturer: Generic
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: Device is not authorized for =
usage
Nov 13 12:32:31 heisenberg kernel: usb 1-5.2: authorized to connect
Nov 13 12:32:31 heisenberg kernel: e1000e 0000:00:1f.6 eth0: NIC Link is Do=
wn
Nov 13 12:32:32 heisenberg kernel: iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIF=
ICATION: 0x20
Nov 13 12:32:32 heisenberg kernel: iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTI=
FICATION: 0x1f
Nov 13 12:32:32 heisenberg kernel: iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0=
x90
Nov 13 12:32:32 heisenberg kernel: iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_=
DW9: 0x0
Nov 13 12:32:32 heisenberg kernel: iwlwifi 0000:00:14.3: RFIm is deactivate=
d, reason =3D 4
Nov 13 12:33:06 heisenberg kernel: tpm tpm0: NULL Seed name comparison fail=
ed
Nov 13 12:33:16 heisenberg kernel: tpm tpm0: NULL Seed name comparison fail=
ed
Nov 13 12:33:26 heisenberg kernel: tpm tpm0: NULL Seed name comparison fail=
ed
Nov 13 12:33:30 heisenberg kernel: wlan0: authenticate with 40:e3:d6:51:2a:=
30 (local address=3D7c:b5:66:f7:a8:a5)
Nov 13 12:33:30 heisenberg kernel: wlan0: send auth to 40:e3:d6:51:2a:30 (t=
ry 1/3)
Nov 13 12:33:30 heisenberg kernel: wlan0: authenticated
Nov 13 12:33:30 heisenberg kernel: wlan0: associate with 40:e3:d6:51:2a:30 =
(try 1/3)
Nov 13 12:33:30 heisenberg kernel: wlan0: RX AssocResp from 40:e3:d6:51:2a:=
30 (capab=3D0x411 status=3D0 aid=3D8)
Nov 13 12:33:30 heisenberg kernel: wlan0: associated
Nov 13 12:33:30 heisenberg kernel: wlan0: Limiting TX power to 23 (23 - 0) =
dBm as advertised by 40:e3:d6:51:2a:30
Nov 13 12:33:31 heisenberg kernel: IPv4: martian source 255.255.255.255 fro=
m 10.183.63.252, on dev wlan0
Nov 13 12:33:31 heisenberg kernel: ll header: 00000000: 7c b5 66 f7 a8 a5 f=
c bd 67 c1 e2 ff 08 00
Nov 13 12:33:31 heisenberg kernel: IPv4: martian source 255.255.255.255 fro=
m 10.183.63.252, on dev wlan0
Nov 13 12:33:31 heisenberg kernel: ll header: 00000000: 7c b5 66 f7 a8 a5 f=
c bd 67 c1 e2 ff 08 00
Nov 13 12:33:31 heisenberg kernel: IPv4: martian source 255.255.255.255 fro=
m 10.183.63.253, on dev wlan0
Nov 13 12:33:31 heisenberg kernel: ll header: 00000000: 7c b5 66 f7 a8 a5 f=
c bd 67 16 62 33 08 00
Nov 13 12:33:31 heisenberg kernel: IPv4: martian source 255.255.255.255 fro=
m 10.183.63.253, on dev wlan0
Nov 13 12:33:31 heisenberg kernel: ll header: 00000000: 7c b5 66 f7 a8 a5 f=
c bd 67 16 62 33 08 00
Nov 13 12:33:36 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 13 12:33:46 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 13 12:33:57 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 13 12:34:07 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 13 12:34:17 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 13 12:34:27 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary
Nov 13 12:34:38 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred at=
tempting to create NULL primary


Any ideas? :-)

Thanks,
Chris.

