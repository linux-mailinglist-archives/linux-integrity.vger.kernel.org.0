Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9FD7A6FB
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfG3LbX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 07:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfG3LbW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 07:31:22 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22AAE2087F;
        Tue, 30 Jul 2019 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564486282;
        bh=UzuT1ht2UlH1HsA6I56EcK7JT5cqdTD0Gg6pUQ/5nJE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=WYqqTVCmkN6C6w37bNAJv6TvB7KhXScyL1GWhj8NmgaJETR9olfNBolURvGIx5iKd
         zndkFhT91VwEjXMqczMETuiNoqlBwJKzS1CtEd4AWZCn54vHLhchVSN4P6iKChubX9
         V2cNMfe7BtWLihaOjK7KgtEkLyXI8027BNSrES68=
Message-ID: <1564486265.4189.29.camel@kernel.org>
Subject: Re: [PATCH] ima-evm-utils: Fix ima_verify for v1 signatures
From:   Mimi Zohar <zohar@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 30 Jul 2019 07:31:05 -0400
In-Reply-To: <20190726222309.8106-1-vt@altlinux.org>
References: <20190726222309.8106-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-27 at 01:23 +0300, Vitaly Chikunov wrote:
> Use user supplied key in verify_hash for DIGSIG_VERSION_1.
> Otherwise v1 signatures don't pass verification.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks!

Mimi
