Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D2F3BE342
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGGGtN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 02:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGGtN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 02:49:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA3EC061574;
        Tue,  6 Jul 2021 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cYpy1cFOr0TzKNP5uFALn0lRGwsuuaoCaJWDTenZy6U=; b=BlzwxryZKrxYXDahRsUaN/d93h
        RPcPBphwW7UxEf49PRYCpljT8DPOIbY/1cOtojNNjVG9W343LJ1ku1eyyJiNcpFa7GWtTeEB3DYDO
        o1bH33nRYai2EIVNDGEMxLEJIC0VHdA+mv/lspSk+raAYY0hI1WdroO7O6BTDb25Qz3LLej0N6t5O
        +Tlpw8dTtyejSXAyUhfHP0Mq1txx0h9VGWpcFzoTzb/he77QJ8mafTtp3VK07ZHI1UwKy9t27EEKC
        nRsU7IbQVJcGOCwpO3LQtk+sT8a6TVkA0rTj+EHXyLIeTCL/TDih1M07UrqPs9NuKyfK/0yK2vVXd
        D6+7AQaw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m11Ju-00C8Jg-Tl; Wed, 07 Jul 2021 06:46:10 +0000
Date:   Wed, 7 Jul 2021 07:46:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
Message-ID: <YOVNrhxCJpfTbpVq@infradead.org>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 06, 2021 at 10:43:51PM -0400, Eric Snowberg wrote:
> This is a follow up to the "Add additional MOK vars" [1] series I 
> previously sent.  This series incorporates the feedback given 
> both publicly on the mailing list and privately from Mimi. This 
> series just focuses on getting end-user keys into the kernel trust 
> boundary.

WTF is MOK?
