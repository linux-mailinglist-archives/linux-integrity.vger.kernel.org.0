Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72477E11
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jul 2019 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfG1ExF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Jul 2019 00:53:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48820 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfG1ExF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jul 2019 00:53:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 38A1E72CC6C;
        Sun, 28 Jul 2019 07:53:03 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 238464A4A29;
        Sun, 28 Jul 2019 07:53:03 +0300 (MSK)
Date:   Sun, 28 Jul 2019 07:53:02 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190728045302.cziuajr3532r3b53@altlinux.org>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190725061855.3734-1-vt@altlinux.org>
 <20190726130708.GA4542@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190726130708.GA4542@dell5510>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Petr, Bruno,

Thanks for reviews! I think I will rework the tests one more time. So
that they can support EVM signatures too w/o too much code duplication.

Thanks,

