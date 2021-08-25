Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2863F6D54
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 04:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhHYCLs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 22:11:48 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21104 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhHYCLs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 22:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1629857426; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=iPNY0Lm2xQU0W7XwDtIE6SOu4GH5QePOWGUQs6Qg0U9PONN9gPMfg5XPiO8SxxbBlVCx6bXt+ta8bmcYtmSrWI0voDWKOl2TC8Khu4j88Xz0jQtpnoPtGx1f2Fpx2qSpx5nQfOp75vjgHX3zwxYPImoshHS0+sMCg8Urj7owoXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1629857426; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=EW4MjGTVwYJgE+935/0lwYuBbIgSXYbtlsZKkKFkB0w=; 
        b=kHJL6VY2fb9JQ2ce5pYYg4xiqFRZkn3QlLPKMIT+MV4WVpPBFH9oEhayRDN/iW4lavPb4wiTkTAXR7z+7LDpw/xrvTQqBNZAkeJmuxbPw8LL3KQHFV7kGJ2SgmurnDzGQSY3mVL07WZI7cC3BOuhLp3Eu6Lc9gy2wuyhf8AiHMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629857426;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=EW4MjGTVwYJgE+935/0lwYuBbIgSXYbtlsZKkKFkB0w=;
        b=pBV8y4/4zpYQsPzg6Kg66nRFWqt75lKoC9oHsHtBErzcAVDWx9qqTY1/m228IOze
        441OLy1hueS22Lxu8nHK2P5hs4acGvXFkGYU+QhMwsjScWJa0anUR1LXaA8uuE5RCPH
        GQYkJkzPxmjt58KNVgkd5OWLDfhXOp53oNiWUXcA=
Received: from [10.10.1.24] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 162985742413164.47891803749803; Tue, 24 Aug 2021 19:10:24 -0700 (PDT)
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
 <20210810162320.6rfpvdvzgxi35ylx@kernel.org>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v3 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <1de59a4d-b29f-2a67-1cbe-8d5f80e59ba5@apertussolutions.com>
Date:   Tue, 24 Aug 2021 22:10:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210810162320.6rfpvdvzgxi35ylx@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/10/21 12:23 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 09, 2021 at 12:38:42PM -0400, Ross Philipson wrote:
>> The focus of Trechboot project (https://github.com/TrenchBoot) is to
>> enhance the boot security and integrity. This requires the linux kernel
>                                                              ~~~~~
>                                                              Linux
> 
> How does it enhance it? The following sentence explains the requirements
> for the Linux kernel, i.e. it's a question without answer. And if there
> is no answer, there is no need to merge this.

We have added a documentation patch that provides background
information, an overview of the capability, and details about the
implementation. We can reword the cover letter, adding reference to this
documentation. And ack on fixing the incorrect case on Linux.

V/r
dps
