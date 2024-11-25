Return-Path: <linux-integrity+bounces-4192-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21239D8719
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 14:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981FAB28780
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC52B21106;
	Mon, 25 Nov 2024 13:03:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE13944F
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539790; cv=none; b=hTfDe+5P2YDOYBEe4cpbLbqtadlCuxlSxqWr4KlV6R0A9hulabU3LWu++tjlCpNw7+v0J/b/jYhmaP9+apEP3RQODDwcanCwpj2slzJYdjmDIevYeDV2bbAZ5ZTslcWp4b0+BL8V3TjzOIDIwpoLyBQ0z7oPZZhmqSfFWBXwdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539790; c=relaxed/simple;
	bh=flh/aF4s1xCcBDAo/e+fVtUohz9/+5T1Fhbat7YOedg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xx4hE1dqfI8KSbGujYm+Lm5zAR/OWZgOn21Yskp6raklg1tHy7xGuAGjanpSxVym4FjvYSTxzqBslB/3oDItZcYA4gWjpHFq0fJClqkWJjR2aQ5OCfkN1A3Veoxw9sGikMDC/MKdwOzFtpvRSuePDgo1xtqQ9oWGL4ZBqJ+HSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XxlY44xv7z9v7JW
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 20:35:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 55C0B1405F5
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 21:02:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBnHzBxdURnAM9EAg--.22643S2;
	Mon, 25 Nov 2024 14:02:49 +0100 (CET)
Message-ID: <d45b753419a5aaa752e1a2ab2645a4c1ba203049.camel@huaweicloud.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>, 
	linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, "M: Roberto Sassu"
 <roberto.sassu@huawei.com>, "M: Dmitry Kasatkin"
 <dmitry.kasatkin@gmail.com>,  "R: Eric Snowberg"
 <eric.snowberg@oracle.com>, Casey Schaufler <casey@schaufler-ca.com>, Paul
 Moore <paul@paul-moore.com>
Date: Mon, 25 Nov 2024 14:02:37 +0100
In-Reply-To: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
References: 
	<CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBnHzBxdURnAM9EAg--.22643S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw48KFyktFWkWFWxtw45Awb_yoWkWrc_ur
	Z0kry7Kw47Zrn3XF47Wr1fKFZ8u3yIkF1DXr10qanagayDArs3ArWDZr93GrWrGr4IgFZ0
	kF95JrnxKrn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGdD4LUD7wAAsK

On Mon, 2024-11-25 at 12:38 +0100, Christian G=C3=B6ttsche wrote:
> Hi,
>=20
> I noticed that the `prop` parameter of `ima_match_rules()` is
> currently unused (due to shadowing).
> Is that by design or a mishap of the recent rework?
>=20
> Related commits:
>=20
> 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")

Uhm, interesting...

To me it seems a variable naming collision.

We are first declaring a new variable:

-		u32 osid;
+		struct lsm_prop prop =3D { };

And then, we are introducing a parameter with the same name:

 static bool ima_match_rules(struct ima_rule_entry *rule,
 			    struct mnt_idmap *idmap,
 			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
+			    struct lsm_prop *prop, enum ima_hooks func, int mask,

I think we should call the first variable inode_prop, and we should pass pr=
op here:

 		case LSM_SUBJ_TYPE:
-			/* scaffolding */
-			prop.scaffold.secid =3D secid;
 			rc =3D ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
 						   Audit_equal,
Roberto


