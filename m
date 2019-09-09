Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB37AE04C
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 23:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfIIVfL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 17:35:11 -0400
Received: from namei.org ([65.99.196.166]:43508 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbfIIVfK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 17:35:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x89LYsHY019848;
        Mon, 9 Sep 2019 21:34:54 GMT
Date:   Mon, 9 Sep 2019 14:34:54 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, sashal@kernel.org,
        kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
In-Reply-To: <1568035881.4614.347.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1909091429050.19397@namei.org>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>         <1567041083.6115.133.camel@linux.ibm.com>         <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>         <1567190507.10024.134.camel@linux.ibm.com>        
 <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com> <1568035881.4614.347.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1758340488-1568064894=:19397"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1758340488-1568064894=:19397
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 9 Sep 2019, Mimi Zohar wrote:

> The remote attestation server could gate any service based on the
> certificate signer.  The first gated service, based on this feature,
> will probably be network access (eg. TNC).  If/when this feature is
> upstreamed, every company, including financial institutes,
> organizations, and governments will become THE certificate signer for
> their organization, in order to limit access to their network and
> systems.

This is already happening at scale, and a primary use-case for the 
patchset.

> Once that happens, how long will it be until the same
> feature will be abused and used to limit the individual's ability to
> pick and choose which applications may run on their systems.[1]

Isn't this already happening (in a non-abusive way) with mobile devices?

> Mimi
> 
> [1] Refer to Richard Stallman's last paragraph https://www.gnu.org/phi
> losophy/can-you-trust.en.html

Please consider if you really want to be endorsing this individual.


-- 
James Morris
<jmorris@namei.org>

--1665246916-1758340488-1568064894=:19397--
