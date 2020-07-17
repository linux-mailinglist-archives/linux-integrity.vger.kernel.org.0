Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8D22442D
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGQTYv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 15:24:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45484 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTYv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 15:24:51 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BAD8220B4909;
        Fri, 17 Jul 2020 12:24:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAD8220B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595013890;
        bh=ivjTtf6Ir0rqIr7x6YfCCMUhM1xuE0XyXrXJpxur7rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAI7jW8F3YgEhMYTHqpP+4G6Cumfh3qHHczB0F/kTToXYJ8WbOp272vrjIBUMeqQQ
         dfhbsNzplo0z71UPAkvHoO/GlCvTpMyw7ysT91MzeGukBhYou4t2R90AuHNI9974v0
         GM2TG8zi568RF1zxV9VXRzh+m97ZsYkr/CyjZm7s=
Date:   Fri, 17 Jul 2020 14:24:47 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v3 01/12] ima: Have the LSM free its audit rule
Message-ID: <20200717192447.GO3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-2-tyhicks@linux.microsoft.com>
 <5ee27a51-7ff9-5763-c85f-e99e62458657@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ee27a51-7ff9-5763-c85f-e99e62458657@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-17 15:20:22, Nayna wrote:
> 
> On 7/9/20 2:19 AM, Tyler Hicks wrote:
> > Ask the LSM to free its audit rule rather than directly calling kfree().
> 
> Is it to be called audit rule or filter rule ?  Likewise in subject line.

The security hooks call this "audit rule" but Mimi explained the
reasoning for IMA referring to this as an "audit filter" here:

 https://lore.kernel.org/lkml/1593466203.5085.62.camel@linux.ibm.com/

I would be fine with her renaming/rewording this patch, accordingly, in
next-integrity-testing.

Tyler

> 
> Thanks & Regards,
> 
>     - Nayna
