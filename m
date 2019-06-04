Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853163508C
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFDUDd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 16:03:33 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35021 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDUDc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 16:03:32 -0400
Received: by mail-it1-f195.google.com with SMTP id n189so48659itd.0
        for <linux-integrity@vger.kernel.org>; Tue, 04 Jun 2019 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m9ImxAK4nx5wz47kwUXxq4IaRpk9/ezj49uqbRZAOw=;
        b=N1JffQkfp3HwSkEUirFC/rdMrd4dpMZKMUg4ZAE47BVRtwvArTCoJfMfVWEkYh6/OY
         VCXtIhBaXhtvCocRhB0EXkgj/Sg4SXP4HHycZ4wfQqlV/+foufoIkNw43NtdCRokrAX/
         PfwJS2sosrnuJRLASDakV7vw+qnRoL09jsoJs4VYv6C+dNRUunCX9wDH/m83f7Y8XXSr
         uYuVXOT3uSlFsGW4aKzUmnvy19APhOyFbf4M2dlS/gTJYIlmmiySYErRpy78Z7Kb3/JR
         es3tL/KNxIf5BxHcoxf3a2T/K1om+OFWVn+9+5N9v53kgJvDYsVxxn0BzA4d96EwM8V/
         sacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m9ImxAK4nx5wz47kwUXxq4IaRpk9/ezj49uqbRZAOw=;
        b=CMJrQ7HWAzSUgXkZfiQBOa8K3r35n4v/nmaCSJcyFVEv9U17/7T8hlrFH2DFVXQhFc
         1deU8wMZyYwTQCeQEERfiRxgTdxTrhkisri9I9QLVb8Sa705u6+IvXp2GyjAGOd/Dfrd
         zbtOWacCdeuAijT4XHbex/UtysYcsvrtQVZdY3/wIDEH7+pfjNGvahuFDbna+PMlrgOQ
         mBJZ1xFZOvnAjrW4GBYQTwB1UICWVroP2Ol0gtIY7MnF7Fr2dOAdwYXxDxxs9peuBp6W
         awk7sdIQj46zLjg4AzoBq8A1yA2KqUM2nthc9nzvZiFVGZ3gWmREk5Q1L5iQoY+/jHqy
         8Hbw==
X-Gm-Message-State: APjAAAW0YaiPFaWj6XsZUSTjEHl1u3Akb8pYJA3r+yk4t+HMxx88tl83
        zQzvAYoqOAsqU4mixpBk/1B5xpN32fba+EEAIq1moA==
X-Google-Smtp-Source: APXvYqwxX79yamU/DtBPPJ+TV8TqpZTxtEGMK+l2qmhFCHVLRRoxzVMO/Mgotlu6eRzVLG7P4WEDMiRm3x0uklfiTIg=
X-Received: by 2002:a02:3308:: with SMTP id c8mr7644982jae.103.1559678611725;
 Tue, 04 Jun 2019 13:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190603201322.7443-1-matthewgarrett@google.com> <1559613113.3956.9.camel@linux.ibm.com>
In-Reply-To: <1559613113.3956.9.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 4 Jun 2019 13:03:20 -0700
Message-ID: <CACdnJuvYzGBsAvmcP_6u+Zvr+AKTrKweJDbjurtZ02-HBbJN1Q@mail.gmail.com>
Subject: Re: [PATCH V3] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 3, 2019 at 6:52 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Mon, 2019-06-03 at 13:13 -0700, Matthew Garrett wrote:
> > +                     template:= name or format of a defined IMA template
> > +                     type (eg,ima-ng or d-ng|n-ng). Only valid when action
> > +                     is "measure".
>
> This patch only supports specifying the template name, not the
> template format description.  Please remove "d-ng|n-ng".

It supports specifying the template format, as long as the template
format is already defined. I can remove the example, but it'll still
work.

> >       struct ima_rule_entry *entry;
> >       int action = 0, actmask = flags | (flags << 1);
> > @@ -438,6 +441,11 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> >               if ((pcr) && (entry->flags & IMA_PCR))
> >                       *pcr = entry->pcr;
> >
> > +             if (template_desc && entry->template)
> > +                     *template_desc = entry->template;
> > +             else
> > +                     *template_desc = ima_template_desc_current();
> > +
>
> This code is finding the template format, but is subsequently being
> replaced with the current description.  One way of fixing this, is by
> initializing the template_desc before walking the list.

Ok.
