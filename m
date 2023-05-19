Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390D709ABC
	for <lists+linux-integrity@lfdr.de>; Fri, 19 May 2023 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjESO6o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 May 2023 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjESO6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 May 2023 10:58:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960CEC7
        for <linux-integrity@vger.kernel.org>; Fri, 19 May 2023 07:58:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-561bb2be5f8so42908057b3.0
        for <linux-integrity@vger.kernel.org>; Fri, 19 May 2023 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684508322; x=1687100322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AajyqWszb0uY6qD9cS3VXYrfDU988bXtZCs1rPMruhw=;
        b=CVjYLnK8pZSm+0s+2JgmOpL6fd7Fh3xe0DrvRV47kW58O8GUdqascT+ihAWb+4/PB5
         57l1fSbdpzDrjebhCKxmt8dH+h8nzNnzfGUC6O47kcvj+/tq7D0PSJjuIJJayEMDuPTp
         RZmYcbvGlGStIcUkuVCBO7399/guNv++G9I5Asoz5DROlHagoZjpYdqO7T9i1NOAzJ1w
         Du4lToaIIcFchOrn0Nn//43a6dCasI0vQfLXRVHExkpStSbCh+g9ayLmw5x0ghVHqblw
         Dsm6QLKodk9RMwxd+A5A9Ln0JG71pTOJEq/9kFiLF97zE4pLcdM5N8FRzbB5GfM0mP18
         P5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684508322; x=1687100322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AajyqWszb0uY6qD9cS3VXYrfDU988bXtZCs1rPMruhw=;
        b=PsqBc8wy0yG7UtLBBa4/uqWuDmSXX6C5Sajgftlah4HM05RboCRjJCN+sPsJz04BNH
         9laSe6rQ7c2TYoBlh2YdE2aPeZxbrO1hUf5gcm6B6oxLgVJiiaB3NO+/jE3xxyhCAokG
         AnZWDWZlgSUHiyLhf/N7Cxd13XYvpWfbRU5j38HQvr64Rg71tp3szIVsESulZy3eapic
         ginsknPlB2RnUbPrnhA0vxUBPwsFHUpRkzOlAKemnBgWvXM3UqdCwd0fXmqP1AroLHnE
         sA2+U7R9a7gAdBerFH8ueaoMzLv4sb0Q5X2tfpfCkJDv5SinjswXmRu5GUY1KeVYyb6f
         pzTw==
X-Gm-Message-State: AC+VfDxjMhM3XnI0BUuEm6f295At0bFAsENHdE+yaKGWFzXo4yQfunYZ
        iJDv0WPr6QpPXGBoJRHxlWz98FfpEZEeGrjOAg8tjpLUdgmn3Ys=
X-Google-Smtp-Source: ACHHUZ4wVQ8Htbed+cTytEWUQf0lb6NRULZiiMX8VBBzsWBICc5rj9+tiqRxdZAlDEbFGOiNVwJSMMDulwZ/apnybkg=
X-Received: by 2002:a81:4e92:0:b0:561:d6dd:bc84 with SMTP id
 c140-20020a814e92000000b00561d6ddbc84mr2216527ywb.48.1684508321812; Fri, 19
 May 2023 07:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
 <cbffa3dee65ecc0884dd16eb3af95c09a28f4297.camel@linux.ibm.com>
 <CAHC9VhSeBn-4UN48NcQWhJqLvQuydt4OvdyUsk9AXcviJ9Cqyw@mail.gmail.com> <49a31515666cb0ecf78909f09d40d29eb5528e0f.camel@linux.ibm.com>
In-Reply-To: <49a31515666cb0ecf78909f09d40d29eb5528e0f.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 May 2023 10:58:30 -0400
Message-ID: <CAHC9VhS7uMMgvwRRDzpZPUQDAeibdkLi0OCdp=j_Q-EcMHm0cw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 18, 2023 at 4:56=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2023-05-18 at 16:46 -0400, Paul Moore wrote:
> > On Fri, Apr 21, 2023 at 10:44=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > On Fri, 2023-04-07 at 09:29 -0400, Jeff Layton wrote:

...

> > I'm going through my review queue to make sure I haven't missed
> > anything and this thread popped up ... Stefan, Mimi, did you get a fix
> > into an upstream tree somewhere?  If not, is it because you are
> > waiting on a review/merge from me into the LSM tree?
>
> Sorry for the delay.  Between vacation and LSS, I just started testing
> Jeff Layton's patch.

No worries, I'm a bit behind too, I just wanted to make sure I wasn't
blocking this thread :)

--=20
paul-moore.com
