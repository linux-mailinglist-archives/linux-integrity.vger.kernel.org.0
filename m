Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76F43980E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 23:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfFGVsy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 17:48:54 -0400
Received: from namei.org ([65.99.196.166]:37652 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbfFGVsy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 17:48:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x57LmlGN031254;
        Fri, 7 Jun 2019 21:48:47 GMT
Date:   Sat, 8 Jun 2019 07:48:47 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
In-Reply-To: <CAHC9VhSrjVmnsAuXDmHVmsyDaEF10nsvdxq7VsfCsh=NfaOMQg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1906080748010.24873@namei.org>
References: <20190605083606.4209-1-janne.karhunen@gmail.com> <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com> <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com> <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com>
 <CAHC9VhTzwPoxYPxYWn15ZQQwM6Q3wGJSRybb-zu_ZDA1xU6ziQ@mail.gmail.com> <alpine.LRH.2.21.1906071043160.21512@namei.org> <CAHC9VhSrjVmnsAuXDmHVmsyDaEF10nsvdxq7VsfCsh=NfaOMQg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 7 Jun 2019, Paul Moore wrote:

> On Thu, Jun 6, 2019 at 8:45 PM James Morris <jmorris@namei.org> wrote:
> > On Wed, 5 Jun 2019, Paul Moore wrote:
> > > On Wed, Jun 5, 2019 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > On 6/5/2019 9:51 AM, Janne Karhunen wrote:
> > > >
> > > > One hook with an added "bool blocking" argument, if
> > > > that's the only difference?
> > >
> > > I think there is value in keeping a similar convention to the notifier
> > > code on which this is based, see include/linux/notifier.h.
> >
> > Although this doesn't seem to be what other users in the kernel are doing.
> 
> How many of them potentially have the need for both blocking and
> non-blocking notifiers?  I didn't go through the entire list of
> callers, but it seems all that I looked at used only one type.  The
> simple fact that we started with one type of notifier for the LSM, and
> we are now switching to the other (and getting lucky that it is safe
> to do so for the existing callers) seems to lend some weight to the
> argument we may need both and adding "block"/"blocking"/etc. to the
> name has value.

Fair enough.


-- 
James Morris
<jmorris@namei.org>

