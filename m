Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538A5361A7
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfFEQwL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 12:52:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42132 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfFEQwL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 12:52:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so19614845lfh.9;
        Wed, 05 Jun 2019 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LH15AqeLqaBd2TWfCSVA4eDJSVkVNn2oogp0202LHvA=;
        b=VNqdJI8SwhyNZBnkM2X4vI7XiurscvjailP9vtfn+gLWzAzab4kv5VCTufHc9UBt2u
         ATPrkri+GOapZ7+1GEo915AlqYZg0GPfKGrZDr42fs5dbZ//uZoTljpYM8tziGXWsDmq
         QU1hm3Fwnc6JAwpxAJIVgncOSJN4ZTjrJKeZI7+YEsG0BJLctw2ZjhYaI90DjN99Zd/t
         rEnBRRD+O+NQxY7+sQaBxru3ehqwWZ0facJbjd+kpzWG/WdydDYK/5ACWykPxMorEfS4
         jF+FHcWlRI37B26PHtU7ZmkByS5Z1Duz3JWE6qTg9zq0hMCLojzGJ5+NbuyuWqRCRS3I
         RwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LH15AqeLqaBd2TWfCSVA4eDJSVkVNn2oogp0202LHvA=;
        b=B02Ea3WHuBaTae5jSx5Cu6JLSmHsAW51GC+VNJO4tEEaYEmYaXepAgUDkEFw1EZnsI
         3Q3Q2XtZdV+L8Ftfy8gdjj7weKJ0t0Tq6geP91S8rqPvBIztNZFGMcTb/fKJx4VJIIUa
         UY42ktDm20p7zxJsy2uQCsrbLwqr/gWb/IhNNT9VjYadYBC1OWNOqy+Q0vp4paFYwCIq
         76F5EizylprOzASk9VaWM9X9h8K7ZDoqLIZvchgGUPz8Fk7HGdYrmApQI70XD6PzJbP2
         Jljj5EG/eKMc8Yo8ujoFSJeswgXHiiCPXw3Tyvm+c5TzuSB/DlKh9BqhHeZsqxp3XFTI
         jWGw==
X-Gm-Message-State: APjAAAX719ZOdzAPdxbH1yW8lbGrVhrokGc81Ek7WB7P+wBCdY9Y3Paf
        6/6euzMUqr5rEOhp15evTfveJnvY6UNyIxQoYiY=
X-Google-Smtp-Source: APXvYqxjQc3UNUjEqNVbke0vJMD5o0gHLAvbeE06J8slceoYHcWrUkTuhFMcl454FBRxfFSXKXqCxsyImXwPNPdlcG0=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr20796361lfa.42.1559753529628;
 Wed, 05 Jun 2019 09:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190605083606.4209-1-janne.karhunen@gmail.com> <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com>
In-Reply-To: <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 5 Jun 2019 19:51:58 +0300
Message-ID: <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 5, 2019 at 6:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:

> > -int call_lsm_notifier(enum lsm_event event, void *data);
> > -int register_lsm_notifier(struct notifier_block *nb);
> > -int unregister_lsm_notifier(struct notifier_block *nb);
> > +int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> > +int register_blocking_lsm_notifier(struct notifier_block *nb);
> > +int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>
> Why is it important to change the names of these hooks?
> It's not like you had call_atomic_lsm_notifier() before.
> It seems like a lot of unnecessary code churn.

Paul was thinking there will eventually be two sets of notifiers
(atomic and blocking) and this creates the clear separation. That's
probably true, but it does indeed create a pretty big change that it
is not really needed yet. I'm fine either way.


--
Janne
