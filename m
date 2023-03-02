Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EDE6A8903
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 20:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCBTGK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 14:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCBTGH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 14:06:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF555059
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 11:05:47 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id fd25so109636pfb.1
        for <linux-integrity@vger.kernel.org>; Thu, 02 Mar 2023 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677783944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKw96YimrLV8F+VfPY0RJRLjcN/M6IW13R0RuH+pecA=;
        b=VCO2DicSEeiMX+SOIrKaRJ5XhIN4KXPY8Kb+Ikg8S+mCpFMxAZpeJFjuI31ZkQIW2y
         cVPM6hCUsQCWEcqbgbQh4NnZr3wKxX+r/tYvr5lIlcAKsi34j/SrsGwFr1LgT5QlhBSa
         5T/rW12JgrQDAIh6QOTyQ8w31z7yODrc47MCgw2NEAM9vfeA9L4pgIEV2OtTIdLUK4HC
         z850yeKlFSnJ+60oeiUiqcA/q5+sVMTDVqrdpkYoD1lGZ20+9jnpn2tZwNDS0wecYXze
         m06OFzrEYX/EP2RrsscQDO7EVkrX6je7Ds5CUjinGlSRtNo8k0qShilWmjre44DxrSWy
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKw96YimrLV8F+VfPY0RJRLjcN/M6IW13R0RuH+pecA=;
        b=Bslvjk8SFpXOhz8gCVhFd+MK0nLPd0WQ7AUmBeKFnZNsag2ImcQl95GWFj4KHrAPNn
         Flgbib6oDmn9REIV71sButEizD3WNcnAnfA30wWSDZQEWrYXCS4I02QW7R4BLoftql6B
         j+t07QQNMkvkZELzltj1JvR218/xtxMep3ayPUfRJoxscH1QDcYSTHlBuaJl9+rCsA+F
         iSxbdG9z3ynn4Wi70BqH/bmH/YRFcVSG1FLxwmeEtbF9K/Tnp8J926H5+MN2U6iyggGX
         qvuDeEj2hOjOFp0LZtfCZOSas8eVei0Uqheyd9HGw+4x5Ni0oRQW8+9CEqDo0vP6cx4f
         zoUg==
X-Gm-Message-State: AO0yUKUZUT1KEK7gWbpIqsQVh4RsQ06shBih9zvGoCMXFfCDGKY7fijN
        m89dfK41J/ghfMSmVj3CP6jrfk+Vy7/S2go8t8k4
X-Google-Smtp-Source: AK7set9GakAc9W3sffqku5Nxb155E64D4u0/V0fl7OjF3yznVOjHB2ZwEOd+/4xCl7X6UG3aM5pSV/5L2w6ebrSd6Mw=
X-Received: by 2002:a05:6a00:26d0:b0:590:3182:9339 with SMTP id
 p16-20020a056a0026d000b0059031829339mr4326518pfw.0.1677783944283; Thu, 02 Mar
 2023 11:05:44 -0800 (PST)
MIME-Version: 1.0
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com>
 <1675119451-23180-8-git-send-email-wufan@linux.microsoft.com> <3723852.kQq0lBPeGt@x2>
In-Reply-To: <3723852.kQq0lBPeGt@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Mar 2023 14:05:33 -0500
Message-ID: <CAHC9VhRqMrTuvVtwzJoK2U=6O1QuaQ8ceA6+qm=6ib0TOUEeSw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 07/16] uapi|audit|ipe: add ipe auditing support
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, linux-audit@redhat.com,
        Fan Wu <wufan@linux.microsoft.com>, dm-devel@redhat.com,
        linux-doc@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 31, 2023 at 12:11=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wr=
ote:
>
> Hello,
>
> On Monday, January 30, 2023 5:57:22 PM EST Fan Wu wrote:
> > From: Deven Bowers <deven.desai@linux.microsoft.com>
> >
> > Users of IPE require a way to identify when and why an operation fails,
> > allowing them to both respond to violations of policy and be notified
> > of potentially malicious actions on their systens with respect to IPE
> > itself.
> >
> > The new 1420 audit, AUDIT_IPE_ACCESS indicates the result of a policy
> > evaulation of a resource. The other two events, AUDIT_MAC_POLICY_LOAD,
> > and AUDIT_MAC_CONFIG_CHANGE represent a new policy was loaded into the
> > kernel and the currently active policy changed, respectively.
>
> Typically when you reuse an existing record type, it is expected to maint=
ain
> the same fields in the same order. Also, it is expect that fields that ar=
e
> common across diferent records have the same meaning. To aid in this, we =
have
> a field dictionary here:
>
> https://github.com/linux-audit/audit-documentation/blob/main/specs/fields=
/
> field-dictionary.csv
>
> For example, dev is expected to be 2 hex numbers separated by a colon whi=
ch
> are the device major and minor numbers. But down a couple lines from here=
, we
> find dev=3D"tmpfs". But isn't that a filesystem type?

What Steve said.

I'll also add an administrative note, we just moved upstream Linux
audit development to a new mailing list, audit@vger.kernel.org, please
use that in future patch submissions.  As a positive, it's a fully
open list so you won't run into moderation delays/notifications/etc.

> > This patch also adds support for success auditing, allowing users to
> > identify how a resource passed policy. It is recommended to use this
> > option with caution, as it is quite noisy.
> >
> > This patch adds the following audit records:
> >
> >   audit: AUDIT1420 path=3D"/tmp/tmpwxmam366/deny/bin/hello" dev=3D"tmpf=
s"
> >     ino=3D72 rule=3D"DEFAULT op=3DEXECUTE action=3DDENY"
>
> Do we really need to log the whole rule?

Fan, would it be reasonable to list the properties which caused the
access denial?  That seems like it might be more helpful than the
specific rule, or am I missing something?

> >   The above audit record shows IPE blocked a file
> >     /tmp/tmpwxmam366/deny/bin/hello in the temp file system.
> >
> >   audit: AUDIT1420 path=3D"/tmp/tmpxkvb3d9x/deny/bin/hello" dev=3D"tmpf=
s"
> >     ino=3D157 rule=3D"DEFAULT action=3DDENY"
> >
> >   The above audit record shows IPE blocked a file
> >     /tmp/tmpxkvb3d9x/deny/bin/hello in the temp file system via another
> >     rule.
> >
> >   audit: MAC_POLICY_LOAD policy_name=3D"dmverity_roothash"
> >     policy_version=3D0.0.0 sha256=3DDC67AC19E05894EFB3170A8E55DE529794E=
248C2
> >     auid=3D4294967295 ses=3D4294967295 lsm=3Dipe res=3D1
>
> The MAC_POLICY_LOAD record type simply states the lsm that had it's polic=
y
> loaded. There isn't name, version, and hash information. I'd prefer to se=
e
> all users of this record type decide if it should be extended because the=
y
> also have that information available to record.

Not all LSMs which load policy have that information; as an example,
SELinux doesn't have the concept of a policy name or version.  The
SELinux policy version you might see in the kernel sources refers to
the policy format version and has no bearing on the actual policy
content beyond that dictated by the format.

If additional information is required by IPE, perhaps an auxiliary IPE
policy load record could be created with those additional fields.

> >   The above audit record shows IPE loaded a new policy named
> >     "dmverity_roothash" with the sha256 hash of the policy.
> >
> >   audit: MAC_CONFIG_CHANGE old_active_pol_name=3D"Allow_All"
> >     old_active_pol_version=3D0.0.0
> >     old_sha256=3DDA39A3EE5E6B4B0D3255BFEF95601890AFD80709
> >     new_active_pol_name=3D"dmverity_roothash" new_active_pol_version=3D=
0.0.0
> >     new_sha256=3DDC67AC19E05894EFB3170A8E55DE529794E248C2
> >     auid=3D4294967295 ses=3D4294967295 lsm=3Dipe res=3D1
> >
> >   The above audit record shows IPE's active policy switched from
> >     "Allow_All" to "dmverity_roothash".
>
> Shouldn't this just be another MAC_POLICY_LOAD? That would match other LS=
M's.
> The MAC_CONFIG_CHANGE is to denote that a changeable option was modified =
from
> one value to another. But it is still operating under the same policy.

If it is just switching from one previously loaded policy to another,
it seems like MAC_CONFIG_CHANGE might be the best choice.

--
paul-moore.com
