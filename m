Return-Path: <linux-integrity+bounces-5084-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56455A4EF68
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 22:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2769E188F628
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431B91FA262;
	Tue,  4 Mar 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HCArbirE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC51E3DF4
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124000; cv=none; b=EgrMsMuYE81HNRsjBNmqdbEhJ/CgVI/ynei2z3XpX7re0M6s+opv0vyI+TJ/8WzSSO38jSsZ6oK7z2HWkPJANaMWz/GwJDjGYBrvPuIn0sB3v4vbpfL9I7UU7JuUbrT7C5+x2phBcTGP7TE0iwirudwuk497rQrNgcvEm2X6MUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124000; c=relaxed/simple;
	bh=nPRD3iHY0KN1HpzWSNlZ6jjNPt+sY5MxMhN14hTkD7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8Ym9NBfNF2YQGUaw6UiUD/HPoRZzSPHAYf02DECOJj1/u4X+gSTx9gYD/uGy3W37Lg7bOkLm0k8kDK1rRzAWoyNk8ocwQWaNLYf9LBxlWD83o4lB9NYvnYatA4ssCSbsQxIpaRS7lQlZ8CkKGvCcklqZK9nt5ub0t1HlCpvXYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HCArbirE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524KaT99008926;
	Tue, 4 Mar 2025 21:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IXDOt4
	dGMOUZ2E0gjatLE5EUFdlEMv/9mYYSZO4nvko=; b=HCArbirEC4VDWz/iAnbUF/
	XzvO6VEn12hseWchJaKDfCvzYFdTCXwK0W0sfx/OKH/cGBLLPxlxYYLgEFIV9TGJ
	P3KK9vVSv9eBgPxtentk1BYApbPP5tBsPTzlhriefZ7TvrpA7gUbGRtIbQIRKpVn
	ulg9r4zj/eiyA7eY8T9tWAvvqRuM1lgQcUM93qTbovXO5pOA4+eHEtBIvfFS6n3P
	4wE8CGlAuBTVqWS50hGoljGLYOxF3e+qK7c2JoJXH/Ljl6K6xboJ4cl75bK9PQ5y
	z4bA5lZw1o7TE/TK/pI/4BOCLw1bFjgKY7dUTiI3+Vhx2FT63kzmBkypfs0zR4eQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568pp869g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 21:33:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Ilsrg020841;
	Tue, 4 Mar 2025 21:33:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnfhv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 21:33:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524LXBBi27787824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 21:33:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E25858067;
	Tue,  4 Mar 2025 21:33:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A4358068;
	Tue,  4 Mar 2025 21:33:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 21:33:11 +0000 (GMT)
Message-ID: <a0da3808cec92300c67489539fbee3cbfd2fb4e5.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] ima_violations.sh: Update validate() to support
 multiple violations
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date: Tue, 04 Mar 2025 16:33:11 -0500
In-Reply-To: <20250304174342.GA97130@pevik>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
	 <20250304115331.524842-2-zohar@linux.ibm.com>
	 <20250304133101.GC81126@pevik>
	 <678478de87319625e591e8e956a57b31c700bbd2.camel@linux.ibm.com>
	 <54cf5311ec5e0debd6dfd63669e8d01883c0ba23.camel@linux.ibm.com>
	 <20250304174342.GA97130@pevik>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4sbaRRjd-5lJge1lM-hzGxWKfY1NwILp
X-Proofpoint-ORIG-GUID: 4sbaRRjd-5lJge1lM-hzGxWKfY1NwILp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=941
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040173

On Tue, 2025-03-04 at 18:43 +0100, Petr Vorel wrote:
> > On Tue, 2025-03-04 at 09:44 -0500, Mimi Zohar wrote:
> > > On Tue, 2025-03-04 at 14:31 +0100, Petr Vorel wrote:
> > > > Hi Mimi,
>=20
> > > > > Add support for the number of expected violations.  Include the
> > > > > expected number of violations in the output.
>=20
> > > > Unfortunately this works only on fixed kernel (e.g. the one with v1=
 of your
> > > > "ima: limit both open-writers and ToMToU violations" kernel patchse=
t [1]
> > > > (I haven't built v2 [2], but it's really just
> > > > s/IMA_LIMIT_VIOLATIONS/IMA_EMITTED_OPENWRITERS/ =3D> it will work)
>=20
> > > > Testing on any other kernel it fails on first testing after reboot:
>=20
> > > Hi Petr,
>=20
> > > I only tested by specifying the "ima_policy=3Dtcb" on the boot comman=
d line.  This
> > > failure happens when loading the test specific policy rules.  If setu=
p() is
> > > called before loading the test specific policy rules, forcing the $LO=
G file
> > > violation at setup() would be too early.
>=20
> > Sorry, that doesn't seem to be the case.
>=20
> > With the changes to validate(), even the original tests will only work =
on a new
> > kernel.  I'll rework the patch set, so at least the original tests will=
 continue
> > to work.
>=20
> +1, thank you!

Hi Petr,

Since the original three tests don't provide the expected number of violati=
ons,
the following should work for them.  The new tests will fail without the ke=
rnel
patch.  The assumption is that LTP can handle some of the tests, not all of
them, succeeding.  On a new kernel, all of the tests should succeed.  Teste=
d
only with bash.

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.s=
h b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 2fbffc5da..0395f8d0a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -87,12 +87,13 @@ validate()
        local max_attempt=3D3
        local count2 i num_violations_new
=20
-       [ -z "$expected_violations" ] && expected_violations=3D1
-
        for i in $(seq 1 $max_attempt); do
                read num_violations_new < $IMA_VIOLATIONS
                count2=3D"$(get_count $search)"
-               if [ $(($num_violations_new - $num_violations)) -eq $expect=
ed_violations ]; then
+               if [ -z "$expected_violations" ] && \
+                  [ $(($num_violations_new - $num_violations)) -gt 0 ] || =
\
+                  [ $(($num_violations_new - $num_violations)) -eq $expect=
ed_violations ]; then
+                       [ -z "$expected_violations" ] && expected_violation=
s=3D1
                        if [ $count2 -gt $count ]; then
                                tst_res TPASS "$expected_violations $search=
 violation(s) added"
                                return

thanks,

Mimi



