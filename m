Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680D1119D54
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfLJWhk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 17:37:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfLJWhh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 17:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q+RS+5a8o9wq+07+CMSVR9TYy1NNrDciltQqltE4G6k=; b=xWhtti5199BR6ifYz75OENW0V9
        7ISVYz+mSvq8KvWJ9lxmuGHchd7aRqvyG9/jw9Twns+dfr6InaE/53IPQNGXnETzIiRygEHGglJCM
        3MWObYtqHg1Tjx1K3bYHklgiimuhwoiPtqJfI15SQJ13R9Av4VsbpfYe4aRi66ToApx1pCcMM2DPR
        ZUzdVSjTc0peeQsHlyG0L1q2qBfK6SitFZp9JDz2vsPLR7SeWtRwt77lXrsrsNq1SAJxgTSvIZNqL
        wHpSd+/GgH7b4nggBmxRy+j8S3bE99zUrDAIR5vC9WI2jOWCLpQ/P2lnX20c0v8P2MP+UqbyUtUD9
        LA0LU6zQ==;
Received: from [2001:8b0:10b:1:18f8:340d:82f7:145f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieo8M-000739-3O; Tue, 10 Dec 2019 22:37:34 +0000
Date:   Tue, 10 Dec 2019 22:37:31 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <1576004020.3647.13.camel@HansenPartnership.com>
References: <1575984010.3459.4.camel@HansenPartnership.com> <1575936272.31378.50.camel@HansenPartnership.com> <1575936367.31378.52.camel@HansenPartnership.com> <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org> <10037.1575986929@warthog.procyon.org.uk> <1576004020.3647.13.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Howells <dhowells@redhat.com>
CC:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
From:   David Woodhouse <dwmw2@infradead.org>
Message-ID: <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10 December 2019 18:53:40 GMT, James Bottomley <James=2EBottomley@Hanse=
nPartnership=2Ecom> wrote:
>On Tue, 2019-12-10 at 14:08 +0000, David Howells wrote:
>>   Please therefore put bounds checking and error handling in it=2E  And
>> please *don't* just produce broken ASN=2E1 when something goes wrong=2E
>
>OK, I'll make it return an error and add a wrapper for my use case that
>warns on error and causes the function to bail=2E

Traditionally we call that "error handling" :p

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
