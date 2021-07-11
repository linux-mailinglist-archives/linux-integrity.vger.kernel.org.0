Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0413C3C10
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Jul 2021 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhGKMBM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Jul 2021 08:01:12 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45696 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKMBM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Jul 2021 08:01:12 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1056372C8B4;
        Sun, 11 Jul 2021 14:58:25 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E7DF24A46ED;
        Sun, 11 Jul 2021 14:58:24 +0300 (MSK)
Date:   Sun, 11 Jul 2021 14:58:24 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] CI: Add GitHub Actions for ALT Linux
Message-ID: <20210711115824.sja6kn7qhiij4mrv@altlinux.org>
References: <20210711115539.2400162-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210711115539.2400162-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Subject missing ima-evm-utils, I will resend.

Sorry,

On Sun, Jul 11, 2021 at 02:55:39PM +0300, Vitaly Chikunov wrote:
> Build on Sisyphus branch which is bleeding edge repo.
> Package manager is apt-rpm (not APT as it may look from the scripts).
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  .github/workflows/ci.yml | 13 ++++++++++++-
>  ci/alt.sh                | 24 ++++++++++++++++++++++++
>  tests/install-swtpm.sh   | 14 +++++++++++---
>  3 files changed, 47 insertions(+), 4 deletions(-)
>  create mode 100755 ci/alt.sh
