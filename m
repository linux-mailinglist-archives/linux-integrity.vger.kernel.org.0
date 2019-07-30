Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0AB7A72D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 13:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfG3Lm1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 07:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfG3Lm1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 07:42:27 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E277B20644;
        Tue, 30 Jul 2019 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564486946;
        bh=RU629DfCWPZKpSRC5x2N2EW/Mpdm3PmbsW5zoVKZMRE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=rIqZLVxB3o9VnyHv+sGJmQkRVlMgK0xc1sgsXkOijaRbXgeRRKNUGAHz2FBk1uYOu
         ucIirnNEdc5+OTEKDTJRC0Mixi+BXv1MlpjqX8yr0RFNCH/XB/LET5q44ExuIrsxR7
         bBhT9JmfMo+Bk9d+Ubd/6gbOLu/6/eKVNzSO1htY=
Message-ID: <1564486929.4189.32.camel@kernel.org>
Subject: Re: [PATCH 1/2] ima-evm-utils: Fix ima_verify return value on
 multiple files
From:   Mimi Zohar <zohar@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 30 Jul 2019 07:42:09 -0400
In-Reply-To: <20190727031900.7140-1-vt@altlinux.org>
References: <20190727031900.7140-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-27 at 06:18 +0300, Vitaly Chikunov wrote:
> If any tested file results in failure produce failure exit code.
> Previously exit code affected only by the last file tested.
> 
> Fixes: "Allow multiple files in ima_verify"
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> 
> I decided not to rebase "Allow multiple files in ima_verify" to not create
> merge conflicts with "Namespace some too generic object names".

This is fine, thanks.

Mimi
