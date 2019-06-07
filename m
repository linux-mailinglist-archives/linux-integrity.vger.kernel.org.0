Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18F438245
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 02:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfFGApd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 20:45:33 -0400
Received: from namei.org ([65.99.196.166]:37450 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfFGApd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 20:45:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x570jK00022301;
        Fri, 7 Jun 2019 00:45:20 GMT
Date:   Fri, 7 Jun 2019 10:45:20 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
In-Reply-To: <CAHC9VhTzwPoxYPxYWn15ZQQwM6Q3wGJSRybb-zu_ZDA1xU6ziQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1906071043160.21512@namei.org>
References: <20190605083606.4209-1-janne.karhunen@gmail.com> <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com> <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com> <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com>
 <CAHC9VhTzwPoxYPxYWn15ZQQwM6Q3wGJSRybb-zu_ZDA1xU6ziQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 5 Jun 2019, Paul Moore wrote:

> On Wed, Jun 5, 2019 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 6/5/2019 9:51 AM, Janne Karhunen wrote:
> >
> > One hook with an added "bool blocking" argument, if
> > that's the only difference?
> 
> I think there is value in keeping a similar convention to the notifier
> code on which this is based, see include/linux/notifier.h.
> 

Although this doesn't seem to be what other users in the kernel are doing. 
Probably the less code churn the better in this case.


-- 
James Morris
<jmorris@namei.org>

