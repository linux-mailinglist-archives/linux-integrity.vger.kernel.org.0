Return-Path: <linux-integrity+bounces-4347-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3069EC7DC
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9412166954
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9191E9B2A;
	Wed, 11 Dec 2024 08:55:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECC1D7E46;
	Wed, 11 Dec 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907309; cv=none; b=rrD1ieEKpceYj89S7V/i3K5OvTNelLWBR3mWKPHxBsyKgg7BesvPO/U2Yf0npP7qcC+4p02FcfUxW872G+droYZKN44WntQuTTlijGLVgACQteRaXRbh/diXj6vu+d9ex6fGH1YAsq09eEk0lJMqA1KYi2Y/ERpIRjXfgaV6gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907309; c=relaxed/simple;
	bh=8OcxFQjesMKrNcqlMUpJalJTHgVAGWvP/Xjl+AhSYjc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYg6TlpZFPrwiTImP4OTeXozW3Qs3u7Q9vae+CoTm1kq8OwBdMTOl0Azs9uQx06/8dOXi2QOV1laypbk4eR6cFahYCZJ8u4FRoqRGiHxyxVAK9O0Rb45qjI/dXFJhAV3Y3ECMWezCj1Nh6xbqy/lEXUZqi15PbSrVVC2EmLFPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Y7TQW529zz9v7JS;
	Wed, 11 Dec 2024 16:33:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 22DC1140516;
	Wed, 11 Dec 2024 16:54:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAX1zdRU1lnYzk5Aw--.9641S2;
	Wed, 11 Dec 2024 09:54:49 +0100 (CET)
Message-ID: <5401699f8b00ea09367353dc075b5c569ca68d9b.camel@huaweicloud.com>
Subject: Re: [syzbot] Monthly integrity report (Dec 2024)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: syzbot <syzbot+list2eccd137a466e6acfa54@syzkaller.appspotmail.com>, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, "Yuezhang.Mo@sony.com"
 <Yuezhang.Mo@sony.com>
Date: Wed, 11 Dec 2024 09:54:37 +0100
In-Reply-To: <67547425.050a0220.2477f.0019.GAE@google.com>
References: <67547425.050a0220.2477f.0019.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAX1zdRU1lnYzk5Aw--.9641S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxWr43ZF4rGF4rurWUCFg_yoW8XFykpr
	WFkr4xKrsYyF10kFy0g3W2yw10grZY9345Xrn0qry0yFsxCFnIgr1FvrWkur4kur4fC3Z3
	twn0yw18Zw1xZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBGdY+PUB8QABsL

On Sat, 2024-12-07 at 08:13 -0800, syzbot wrote:
> Hello integrity maintainers/developers,
>=20
> This is a 31-day syzbot report for the integrity subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/integrity
>=20
> During the period, 0 new issues were detected and 0 were fixed.
> In total, 3 issues are still open and 8 have already been fixed.
>=20
> Some of the still happening issues:
>=20
> Ref Crashes Repro Title
> <1> 433     No    INFO: task hung in process_measurement (2)
>                   https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85a2=
d536330
> <2> 32      Yes   KMSAN: uninit-value in ima_add_template_entry (2)
>                   https://syzkaller.appspot.com/bug?extid=3D91ae49e1c1a26=
34d20c0

Hi Yuezhang

it seems that the patch causing the report above is:

6630ea49103c exfat: move extend valid_size into ->page_mkwrite()

Currently, didn't develop a fix for it. Could you please have a look?

Thanks

Roberto

> <3> 2       Yes   INFO: task hung in ima_file_free (4)
>                   https://syzkaller.appspot.com/bug?extid=3D8036326eebe7d=
0140944
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> To disable reminders for individual bugs, reply with the following comman=
d:
> #syz set <Ref> no-reminders
>=20
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>=20
> You may send multiple commands in a single email message.


