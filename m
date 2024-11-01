Return-Path: <linux-integrity+bounces-3953-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8D69B87B0
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 01:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C2D282CD3
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AE1C6A3;
	Fri,  1 Nov 2024 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVGqTw4y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED121C687;
	Fri,  1 Nov 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420740; cv=none; b=cgJvT2AvKELAM6zojRkKk9Pxrg4kP91Rf49AAOJlHzkNN25E4I1f8rN9cbsq8YfEY4eMPHQMyXubZAyi7miivnLNR5XV8/DzsxejaP/FPE4YO1I7yT4ZvL+/4fXK1cG6iljclajmXSq1He6nrqku4ez7VxUNNwh3QCnjWF2gLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420740; c=relaxed/simple;
	bh=HJNwLXRR6CKaw7dE7e3OpVGIzJityYG4sPpHMr7s/VM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RX5Dyy0xBX/EAiu+8zRIF0EFK50BGmo/nQWSZ/K8ff4KQYoLpUwKSQfF4W8eAs22hhgJXi5HGgM8l3ANK91vyZEvAjV1c8Yxeq3BAHgbxk/Dv7YAmvEZSCLT5sXPbawgsAsHnlHfZrteTg5RHGDY88xY7gMW6MapTA4mLuWeiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVGqTw4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086A4C4CEC3;
	Fri,  1 Nov 2024 00:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730420739;
	bh=HJNwLXRR6CKaw7dE7e3OpVGIzJityYG4sPpHMr7s/VM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gVGqTw4yA82KeFP1YBXOU/hTaqHk24n7Mi6Cm+4wphOCyn3+vjMg+/rleCgS2E9m9
	 okdoOAxFvL+9o+fDaQBoIOlf8X7QpQCdBw1zjYJwUkrtCzIqh28otESx4GBGdyh8/K
	 xyNFwBwGIhG2fpe6wbEt6IgnfOS69NS+sBd9wz7d//RvxhzMLOt4pjeV7PA18nYSOJ
	 BWaqGdBaZ6L7gSHxUYxYvWrMyk1/0pqM3bhDO2vp9GOjSLhmw/KqZH5QbyG8TGwVKQ
	 0kTQRttrl68/m9j1VzrdHfiSnKTjk2w2uZoTzjNKQ7qzhrf5wzkd9JEelo6kHP7m+E
	 80X3ndgW0SbKw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 02:25:35 +0200
Message-Id: <D5AEYFC1VUYN.24WN7GVHN1MDU@kernel.org>
Cc: <stable@vger.kernel.org>, "Mike Seo" <mikeseohyungjin@gmail.com>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Jerry Snitselaar"
 <jsnitsel@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241101002157.645874-1-jarkko@kernel.org>
In-Reply-To: <20241101002157.645874-1-jarkko@kernel.org>

On Fri Nov 1, 2024 at 2:21 AM EET, Jarkko Sakkinen wrote:
> Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be rac=
y
> according, as this leaves window for tpm_hwrng_read() to be called while
> the operation is in progress. The recent bug report gives also evidence o=
f
> this behaviour.
>
> Aadress this by locking the TPM chip before checking any chip->flags both
> in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
> check inside tpm_get_random() so that it will be always checked only when
> the lock is reserved.
>
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

A basic smoke test in QEMU:

# rtcwake -m mem -s 15
rtcwake -m mem -s 15
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Nov  1 02:21:06 2024
PM: suspend entry (deep)
Filesystems sync: 0.017 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.004 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
printk: Suspending console(s) (use no_console_suspend to debug)
ata2.00: Check power mode failed (err_mask=3D0x1)
ACPI: PM: Preparing to enter system sleep state S3
ACPI: PM: Saving platform NVS memory
Disabling non-boot CPUs ...
ACPI: PM: Low-level resume complete
ACPI: PM: Restoring platform NVS memory
ACPI: PM: Waking up from system sleep state S3
pci 0000:00:01.0: PIIX3: Enabling Passive Release
virtio_blk virtio1: 1/0/0 default/read/poll queues
OOM killer enabled.
Restarting tasks ... done.
random: crng reseeded on system resumption
PM: suspend exit
# ata2: found unknown device (class 0)

# dmesg|tail -20
dmesg|tail -20
[   28.199150] Freezing user space processes
[   28.205393] Freezing user space processes completed (elapsed 0.004
seconds)
[   28.206780] OOM killer disabled.
[   28.207858] Freezing remaining freezable tasks
[   28.213224] Freezing remaining freezable tasks completed (elapsed
0.004 seconds)
[   28.214591] printk: Suspending console(s) (use no_console_suspend to
debug)
[   28.222203] ata2.00: Check power mode failed (err_mask=3D0x1)
[   28.240808] ACPI: PM: Preparing to enter system sleep state S3
[   28.241218] ACPI: PM: Saving platform NVS memory
[   28.241390] Disabling non-boot CPUs ...
[   28.243011] ACPI: PM: Low-level resume complete
[   28.243273] ACPI: PM: Restoring platform NVS memory
[   28.246191] ACPI: PM: Waking up from system sleep state S3
[   28.250415] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[   28.256539] virtio_blk virtio1: 1/0/0 default/read/poll queues
[   28.280715] OOM killer enabled.
[   28.281766] Restarting tasks ... done.
[   28.287096] random: crng reseeded on system resumption
[   28.288181] PM: suspend exit
[   28.410073] ata2: found unknown device (class 0)

Testing done with https://codeberg.org/jarkko/linux-tpmdd-test

cmake -Bbuild -Dbuildroot_defconfig=3Dbusybox_x86_64_defconfig && make -Cbu=
ild buildroot-prepare
make -Cbuild/buildroot/build
pushd build/buildroot/build
images/run-qemu.sh &
socat - UNIX-CONNECT:images/serial.sock

BR, Jarkko

