Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA65F409D33
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 21:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbhIMTjM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 15:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242762AbhIMTjL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 15:39:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D1A261103;
        Mon, 13 Sep 2021 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631561875;
        bh=r51FUZSKthLeDF5E7gLhX19fxTyfLcdhuW9f9tvo+ac=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dWHwZFRqjzvMG4wzF+FTWW2RtvOxxL/DlyCFBzfWW59Z7PDPsJgjFI9gB4Yv9/TQI
         DhXuwTUsL2SHAoeBQkoDI9Y/aG70TMEMZgSxrq1n8w2RKMSUfA6PRXKnQBr+bPNswP
         7TsjF8wClM5CHvYedM2zaThVpmBKc1AN1m2fWjemTwhC4U3Fo2CTE2Api7nRlcsuv6
         bCkMhQBqhv2nBjDyzjjdKt6SOWTL7S+EdyVoc3TYOI+z8z+28kMZeyi3kM/3Bl4t+2
         6J17Cz86SwuhKadAkOgCLpBNB33I+cIZF+1PbSK1g2nr/XJ1Gh2DjSxoNHVHpx2XVh
         TnjK5Ld7/qRig==
Message-ID: <38bf74eea9453a43278c23f87b5ebdd699e90fc1.camel@kernel.org>
Subject: Re: [PATCH] integrity: support including firmware ".platform" keys
 at build time
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        seth.forshee@canonical.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 13 Sep 2021 22:37:53 +0300
In-Reply-To: <20210910172515.8430-1-nayna@linux.ibm.com>
References: <20210910172515.8430-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-09-10 at 13:25 -0400, Nayna Jain wrote:
> Firmware keys are loaded on boot onto the ".platform" keyring. In additio=
n,
> allow firmware keys to be compiled into the kernel and loaded onto the
> ".platform" keyring.
>=20
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Lacks completely use case/application.

/Jarkko

