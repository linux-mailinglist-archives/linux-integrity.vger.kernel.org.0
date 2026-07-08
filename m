Return-Path: <linux-integrity+bounces-9904-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nurwAm1ITmqBKAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9904-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Jul 2026 14:54:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791CD7267BA
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Jul 2026 14:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cJ8YmyNG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9904-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9904-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 993B73021879
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2026 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840F466B6C;
	Wed,  8 Jul 2026 12:52:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882524611C2
	for <linux-integrity@vger.kernel.org>; Wed,  8 Jul 2026 12:52:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515127; cv=pass; b=R/09wiVuHtHMX569st2xn9rFZfACa8HQvO78HAL3axyaz8HiQKXtJJqLf2nBQWvVT1Am8v9dxLtvUtYKHykVGLeA0jFxCIgmspv1kQW3w9O7Sb8c/L5ZeYyD2FrjaqstRRUL8AH/mysT9g+0ooP0ByF63f2zKpfB8qQ53VKGAC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515127; c=relaxed/simple;
	bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyTHcbL+bkBxIkc9Er3Loaoe0ziSgi3rpiLbzXCLTwDM8Lt43iKdY2LVCfOdILPs6C10GJl7AFGIATHgDbHsO1M7x5jjLnHlmowv+zGJfMazYSd4uikxQM7t+0NKKylg945+r4Ktp+zVtFzZvteKmkdVydDLkOXRRzkz0JcWyXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ8YmyNG; arc=pass smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so4950656d6.1
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jul 2026 05:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783515123; cv=none;
        d=google.com; s=arc-20260327;
        b=baL2mooWN2Zbd94JEexkNKrBf+SmTdhvp2eR6xCLqGPfmVbqiGQ+s7HcIYf0ddgmMs
         EPMj/xAKW+IJ6ZBPOkXgHLwgJ1YUIkPuTH++Rz6jRxZoPxZE0ioyuM0gdyToMMbNwI6L
         UgYX2WJMCitudz9tHS5OkTr4NMT5DfCbcBtSgmBfTMo4FW44Dr8vLEdwygjelsNC5VtR
         jtBMuTT5HB3p1YIErzNlNVgjZQ3bWnpUVKSw5VCo4ncmI5W/x5v/Y4IyVA7KhdYE8JU/
         +VzMAJ9QQpwKX7qpw/ODpAZ/vUn71G0gPiThGapps8XoxNkacSyMBYfnsF5/ALCPU7NT
         QTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        fh=RfEXU/2QssbCMvTBeu/xrKC5xxPfWoz+5a42e0dSqgM=;
        b=G4zQfVb2Dvht1o7sMEAJoTcvcheMgVKELHmqCC/jgi+mCunclFVlFu+6VunBqvSx6Q
         wxFTT09nuTQesdHUo0rTszPilAwAb4YiYo8asNKHeGwP0eLvxMLLD8jh8qvlz5RImYNt
         7989ppzjShzMvIfzUqbi3Yl3ywRcKrHl7fCdrM5lO6OW+AqxomnidBBGlIlFM86L7CKW
         OPetcIEfjiF852kdA1yKhtQVWHyJ6U+erVs0GjmJvUnhG11U6ikWttyFWbRVdU0tVnXy
         KTooIvctLesE3FomoVfbFkFL0Cv6KfoJtEttKaa5ZvOC3v8Tcc7rtW9RmM6DxMDZdDWL
         IbIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515123; x=1784119923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=cJ8YmyNGzcUVkugDcbDFSV9hG1XDIYcPXiertRg0HgzcUcju9zF9S1QddQvl1IpWUU
         4k5nyw2V0IVysz1RCrUdJrEDo/h/A2qbnGEkhOL3pMSeZq9aNdhek1gxoF3bPioxNI3d
         ggeFj1wflW8RofhZngweDB2Ewf+1+x6kpdbS6g61gDANdxSQ8inNYw98Euig7Tflxz79
         yJ8j6vynosLrChyjPyPwAlM/tzP8CcmxcP2N9+hHViX91g/XicWPJjt9i8qCxLFKR4ur
         hbNv49Trj68z0qWIkUNyQKuPp7su1TchELfMq/n41YFkTwA8KS5WkUEWYHQo3mp6OZbs
         /R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515123; x=1784119923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=eRLWHiTMpkBkJsquCxDoClKmQbhM+QkSoL5p4Aje1NCk9t2uJBtw4IEbIdeB3QjmaS
         gkfcAY2AKGEiTPNQ4ejKmf9j2tYEkCnAj+ps++pUoG/4lWXJiL86bSct0IdzQ3YMyM2B
         2/jtHyc5B7CWAghRZUDlte3dbO/ucgw/5coHfg29Nbv/3pQMjEXEjgoX33iBZHmZhExS
         PzYch46iIxA25HGEPpxWadyH4SxkEbowaoel1Q4cBhYLWIL0VrYJwdBys59Nf/jvJhy9
         zw8ijoqWX/iG+Go0o+Jej6cOGjVXX9dqePVslouumy8mIpJbTcIUCr8U8F8UfvBZfiDN
         oDqw==
X-Forwarded-Encrypted: i=1; AHgh+RrKueOwOY8HKNg3m9ieagETEpXa5Ony2jP9zigGEZNgdLArxga1h77velJJgKsB3jMzzUsUzm+/efj9KlU+ap0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTZwkVeUj9sCPOuMO8/YKTX3y5aM0EaZAIexpjsMlq3wqERmz
	+26d3s93PF6yUG8xSADfkcH3haCkNeSxN6xgL0zc3CyoJBRde6c7UGdoUtAF3AUVHP5QorR9ihf
	4rdV1agRzJqA/QGbGA1g67YryfXaOuGY=
X-Gm-Gg: AfdE7cnKXp4Oa//shfBoj/4ByOJ2ji+EEyZ/T5ql0gRmx1SHEq2euPLPFPyuYB2yq+D
	leUvACrz8FNlXOZjkU+M6sr+BNsaw9BvW4QgDZtLvEstr0h6uCo0G3wbH9ZniQ+lb0ynG9lQ//v
	n3wsJNd96xU0LPwsZvPy1GoStmQ120sMHY6w5a7rkIOgY5UCNSz2Jq2dA2g9nlsnYdPK0+QEBw/
	PR/atDk2byaQ0omJHJPkkgDDqKdBLNT4vAoU25xH5mt8P/ik7f3pH9AVD9CQj/wePcLb4GwWTEq
	W9k1RHv4rErhrgrR6RnQSRdqNzI=
X-Received: by 2002:a05:6214:328c:b0:8fd:6df3:b37a with SMTP id
 6a1803df08f44-8fec361db53mr20328306d6.62.1783515123475; Wed, 08 Jul 2026
 05:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-1-dwindsor@gmail.com> <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
In-Reply-To: <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 8 Jul 2026 08:51:52 -0400
X-Gm-Features: AVVi8CfU37Brxag2yfG62kEk96iHc-RKohKljtHAIy8Sn1Fk6Gh-XV62bqUwhO4
Message-ID: <CAEXv5_j96aUkmSEg4brvk2q-A3SyYzXZ7jyutoXfrc-oDykZYQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:memxor@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:casey@schaufler-ca.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,m:stephensmalleywork@gmail.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9904-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,schaufler-ca.com,redhat.com,linux.ibm.com,huawei.com,oracle.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 791CD7267BA

On Tue, Jul 7, 2026 at 11:12=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Jul 8, 2026 at 2:09 AM CEST, David Windsor wrote:
> > Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
> > extended attributes. For these LSMs, atomic labeling during inode
> > creation is critical: if the inode becomes accessible before its xattr
> > is set, it is briefly unlabeled, which can disrupt LSMs making policy
> > decisions based on file labels.
> >
> > Existing LSMs solve this by setting xattrs directly in the
> > inode_init_security hook, which runs before the inode becomes
> > accessible. BPF LSM programs currently lack this capability because
> > the hook uses an output parameter (xattr_count) that BPF programs
> > cannot write to, and existing kfuncs like bpf_set_dentry_xattr
> > require a dentry that isn't available until after the inode is
> > accessible.
> >
> > This series introduces the bpf_init_inode_xattr() kfunc, which takes
> > the combined inode_init_security xattr context argument and claims a
> > slot in it via the new security_lsmxattr_add() LSM helper.
> >
>
> There are various CI failures in newly added tests, I don't think any of =
them
> are passing. Please fix before respinning.
>
> https://github.com/kernel-patches/bpf/pull/12730
>
> E.g. both test_init_inode_xattr and test_init_inode_xattr_slot do not hav=
e
> expected results.
>

This is happening because the path "/tmp" in bpf ci isn't mounted on
tmpfs, rather on 9p:

[ 5.813072] VFS: Mounted root (9p filesystem) on device 0:22.
[ 5.924390] vmtest: Mounting tmpfs at /dev/shm
[ 5.971012] vmtest: Mounting tmpfs at /run
[ 6.096271] vmtest: Mounting tmpfs at /mnt

... which doesn't call inode_init_security. Changing the test to
create its file in /dev/shm, which has a real tmpfs, fixes this. We
can update the test to skip on filesystems where the hook doesn't
fire.

I'll wait to gather feedback from Alexei and Paul before sending v6.

> pw-bot: cr
>
> > [...]

