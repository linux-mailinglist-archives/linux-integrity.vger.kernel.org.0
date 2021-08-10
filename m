Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742B43E7D6E
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhHJQXp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 12:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhHJQXo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 12:23:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14D0260F02;
        Tue, 10 Aug 2021 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628612602;
        bh=nczmLTVxEQtoxBkAO9L8Lie/2UE68qMsN3DD27DRIPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMNkRNQGRWg7IiWDhIzmGV4aTK74KV5IWwwyH7w5eZzNdbLPDqb4mv8HGpr7JtM8T
         JE+V39EIN/+CqKz7AS7zDJHTBwwZ7eOcleu4b99XNw9KaBwoXG2rPutRnI7eZzb+3l
         oENWbv4zay3ZWfPoeeiWVa5PDHjf587E7MwHuwew0LuMSFPFZteSZF/sZonTLf0SON
         6e8GQUdcWDYTGq3/gZ+ccleZlmVETzBiOyEhOJLBlAdhNeZQbsc6dCDZko/fa4vjJ4
         NoqGXgLRZ6d2H/CTAFl+WTfSkfzp+DGif+X1oETip6u5UZfc+YqZM/ymQfK+nF9BSL
         jmmo8L3Wewyuw==
Date:   Tue, 10 Aug 2021 19:23:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v3 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <20210810162320.6rfpvdvzgxi35ylx@kernel.org>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 09, 2021 at 12:38:42PM -0400, Ross Philipson wrote:
> The focus of Trechboot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity. This requires the linux kernel
                                                             ~~~~~
                                                             Linux

How does it enhance it? The following sentence explains the requirements
for the Linux kernel, i.e. it's a question without answer. And if there
is no answer, there is no need to merge this.

/Jarkko
