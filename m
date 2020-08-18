Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19A248B5C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHRQTx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 12:19:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51336 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgHRQTj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 12:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5F2EA8EE1A9;
        Tue, 18 Aug 2020 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597767575;
        bh=L/MN+lxn8x8KGJbs1vAEkdW/rjO9wlNxW0FetUNgKJE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F3TJolfs2dnkOc99Rj/5Zn8QU8AwiBtf/PoD+Ybd46WQYFKE47TMO4K9Rse9ySnha
         K8EiUDemagYiEcnjDJ3wb7TRylgGNWzB4SBFLklBk+HUeu6VYP1lI7fBVPerHFKl2G
         4AG081qyKmoSiPoq1FuBRwnepFJ2OsaN6DveGoOc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5V37A5Z9zYZ5; Tue, 18 Aug 2020 09:19:34 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1EEAE8EE17F;
        Tue, 18 Aug 2020 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597767574;
        bh=L/MN+lxn8x8KGJbs1vAEkdW/rjO9wlNxW0FetUNgKJE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S1ijLZW5ep+iwtdY2BSLm5T+ZmNajMO7m+g+9JVex4iRAXkSI2+oCoXpb2vIS3IKS
         SC1rbcuo8t6pBK5PPcflRruDFKgZ7qdmGNInHRGVS68Dq7jZisFZrfRFusbJqEojj1
         BioijcDNFNk01kzf/xCm0lQWStYSXsperJU1UIBc=
Message-ID: <1597767571.3898.15.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     krzysztof.struczynski@huawei.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, stefanb@linux.vnet.ibm.com,
        sunyuqiong1988@gmail.com, mkayaalp@cs.binghamton.edu,
        dmitry.kasatkin@gmail.com, serge@hallyn.com, jmorris@namei.org,
        christian@brauner.io, silviu.vlasceanu@huawei.com,
        roberto.sassu@huawei.com
Date:   Tue, 18 Aug 2020 09:19:31 -0700
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N> <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-18 at 17:20 +0200, krzysztof.struczynski@huawei.com
wrote:
> The measurement list remains global, with the assumption that there
> is only one TPM in the system. Each IMA namespace has a unique ID,
> that allows to track measurements per IMA namespace. Processes in one
> namespace, have access only to the measurements from that namespace.
> The exception is made for the initial IMA namespace, whose processes
> have access to all entries.

So I think this can work in the use case where the system owner is
responsible for doing the logging and attestation and the tenants just
trust the owner without requiring an attestation.  However, in a multi-
tenant system you need a way for the attestation to be per-container
(because the combined list of who executed what would be a security
leak between tenants).  Since we can't virtualise the PCRs without
introducing a vtpm this is going to require a vtpm infrastructure like
that used for virtual machines and then we can do IMA logging per
container.

I don't think the above has to be in your first patch set, we just have
to have an idea of how it could be done to show that nothing in this
patch set precludes a follow on from doing this.

James

