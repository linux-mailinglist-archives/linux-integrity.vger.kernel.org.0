Return-Path: <linux-integrity+bounces-9752-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8siOFzT1ImoEfwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9752-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 18:11:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D55649A45
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 18:11:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=a6qgwb8M;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9752-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9752-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15CEC3011C42
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0678D347BA5;
	Fri,  5 Jun 2026 16:00:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBF38B12F;
	Fri,  5 Jun 2026 16:00:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675219; cv=none; b=CDFp2fFiw8DUp/9HEgvA8uLvOexp5ccXMVxm+HhOp6u1Moc7vrOvYYRzkTdonhTvdD5bek+X30eAK30qTMnTWkJHwdh17bl0SyMKNYMzuCjWaaM5ZLXq312do8VVdy/TVHg3ox63wyVdlM6Hbz4rJIlcZ0xky8kaOeLblKLLysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675219; c=relaxed/simple;
	bh=qNiHxQTcd5GWsdF+i/kdaV7pHhTcsPfOYVuWJthh8KM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nDhb0+H3zAQ/PVIjX1SnxRUveCKfmgoUY8XILhPRmJtbq5zQFyxwUY45vToOIMHrI+jqC/3kRWIwfCrides5Mr0fTqhGzk2fui3dOM+hecvR+TkRi5dEIyfDyS10q1OVgwuJA3cwkc/tfyf7aaWsWp2qUDYeXIolaKq0QUC1vs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a6qgwb8M; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6554KD0s2223981;
	Fri, 5 Jun 2026 15:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i07pDU
	z035M602FZ/BVBaNfVaEKYL5dRuQapQ+N7sDM=; b=a6qgwb8MRygaH8Ng2oE/nI
	D0GwVYYV+7EAmAZh+lGaH/oJGvWfrabjrV0k+25wNeacXav7YA96fOrdksyWS2pK
	yILK8EqeaxT++KLc21A/mUxgnN9BYpQhEP1c7Ehdzvt3nTiPNbufcyKA+TKJ1opc
	e4VkENgebcXArKeXgeSC3K7b+v0TeKfsbioAduP1XVdP0m2YVKHihj7hgx9Jh1yM
	ryacSZ+1CKNuRb5FidqHn+CxCKTFJgOetb1hNLJvWWWDxEjAVpUT50D1DB2cHf6Z
	qCmE6OIlTaRtmSqq3VXe6e2cNA3EcktFCNDOkMVNWNUjUUnoz4bHUifMriA/Lqvg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4n9m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 15:59:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655Fs7ew014062;
	Fri, 5 Jun 2026 15:59:52 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceh25dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 15:59:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655Fxp6215598280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 15:59:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 537B35805C;
	Fri,  5 Jun 2026 15:59:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC87058054;
	Fri,  5 Jun 2026 15:59:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.67.126])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 15:59:49 +0000 (GMT)
Message-ID: <fb9de334db1eb72de58d55f5b95a60be189e4856.camel@linux.ibm.com>
Subject: Re: [PATCH v6 12/12] doc: security: Add documentation of exporting
 and deleting IMA measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260602111401.1706052-13-roberto.sassu@huaweicloud.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
	 <20260602111401.1706052-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 11:59:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE1NCBTYWx0ZWRfX3BPELvGqJnXK
 MXZCwJA8ES2NadCtSRJ9kviLSI9R7Zd2A5Sy1Y5/Fwzsf/91Bz/CSdfyotNkdWZZGuZKT3IMe0s
 WGKDdSMWihl0HvBKQ0sXSrUtmFbu8ASHPvO/wbMLkXZIcMJA2etVCp1qOxpXIEXY2/Qu1T9l5G+
 4MLCOG6+Mb306cu2yP9/tzkRwLWdJab2PM9A015ZbzgKJ8rN6pLnOrFiIJ8YuxcXc5/RBqwFUwa
 NKZYzAPpbWBCXeiknG5g/aUCPWg+iyMEdJCC1znzpkrVExjkiJt/LhJ+gn/M+PwMe3XklkZDwbO
 0iHLkXPBd6C0OF9C9Z45TFfESnIgamiLlz0kNlpuxAvM38oQDvG0IwJq+seudME1whk9aXgLbaQ
 nrloNo+ZFoFbafWtwv2c4xU/Y+tm+71do08XUEYDHi3LAIbJZymIzycc9Ua0RYRm7+G2u9VmfRr
 VhXFgpM1WWv/hcxP2YA==
X-Proofpoint-GUID: 3rK2jKOvVejQxW3pOkZasrh_rmD811cC
X-Proofpoint-ORIG-GUID: j30XuGIhpgLw3qeuTEtRW2TA0bdZAO-Y
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a22f279 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=2gXG2BVIBEAsA41MxPYA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050154
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9752-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huaweicloud.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp,oracle.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3D55649A45

On Tue, 2026-06-02 at 13:14 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Add the documentation of exporting and deleting IMA measurements in
> Documentation/security/IMA-export-delete.rst.
>=20
> Also add the missing Documentation/security/IMA-templates.rst file in
> MAINTAINERS.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto!  Other than the section titled "Remote Attestation Agent
Workflow", the documentation is well written and flows nicely.  More detail=
s in
the "Remote Attestation Agent Workflow" section.

> ---
>  Documentation/security/IMA-export-delete.rst | 190 +++++++++++++++++++
>  Documentation/security/index.rst             |   1 +
>  MAINTAINERS                                  |   2 +
>  3 files changed, 193 insertions(+)
>  create mode 100644 Documentation/security/IMA-export-delete.rst
>=20
> diff --git a/Documentation/security/IMA-export-delete.rst b/Documentation=
/security/IMA-export-delete.rst
> new file mode 100644
> index 000000000000..a9e1d3f8ed47
> --- /dev/null
> +++ b/Documentation/security/IMA-export-delete.rst
> @@ -0,0 +1,190 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +IMA Measurements Export and Delete
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The IMA measurements list is currently stored in the kernel memory. Memo=
ry
> +occupation grows linearly with the number of records, and can become a
> +problem especially in environments with reduced resources.
> +
> +While there is an advantage in keeping the IMA measurements list in kern=
el
> +memory, so that it is always available for reading from the securityfs
> +interfaces, storing it elsewhere would make it possible to free precious
> +memory for other kernel usage.
> +
> +The IMA measurements list needs to be retained and safely stored for new
> +attestation servers to validate it. Assuming the IMA measurements list i=
s
> +properly saved, storing it outside the kernel does not introduce securit=
y
> +issues, since its integrity is anyway protected by the TPM.
> +
> +Hence, the new IMA staging mechanism is introduced to export IMA
> +measurements to user space and delete them from kernel space.
> +
> +Staging consists in atomically moving the current measurements list to a
> +temporary list, so that measurements can be deleted afterwards. The stag=
ing
> +operation locks the hot path (racing with addition of new measurements) =
for
> +a very short time, only for swapping the list pointers. Deletion of the
> +measurements instead is done locklessly, away from the hot path.
> +
> +There are two flavors of the staging mechanism. In the staging with prom=
pt,
> +all current measurements are staged, read and deleted upon confirmation.=
 In
> +the staging and deleting flavor, N measurements are staged from the
> +beginning of the current measurements list and immediately deleted witho=
ut
> +confirmation.
> +
> +
> +Management of Staged Measurements
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Since with the staging mechanism measurement records are removed from th=
e
> +kernel, the staged measurements need to be saved in a storage and
> +concatenated together, so that they can be presented to remote attestati=
on
> +agents as if staging was never done. This task can be accomplished by a
> +system service.
> +
> +Coordination is necessary in the case where there are multiple actors
> +requesting measurements to be staged.
> +
> +In the staging with prompt case, the measurement interfaces can be acces=
sed
> +only by one actor (writer) at a time, so the others will get an error un=
til
> +the former closes it. Since the actors don't care about N, when they gai=
n
> +access to the interface, they will get all the staged measurements at th=
e
> +time of their request.
> +
> +In the case of staging and deleting, coordination is more important, sin=
ce
> +there is the risk that two actors unaware of each other compute the valu=
e N
> +on the current measurements list and request IMA to stage N twice.
> +
> +
> +Remote Attestation Agent Workflow
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The example below illustrates a narrow use case in which only a single
attestation server is present, eliminating the need to retain the measureme=
nt
list records. The recommended general case, however, involves multiple
attestation servers and requires the system service to retain all measureme=
nt
records since boot, with the ability to respond with records from any speci=
fied
point onward.

Mimi

> +
> +Users can choose the staging method they find more appropriate for their
> +workflow.
> +
> +If, as an example, a remote attestation agent would like to present to t=
he
> +remote attestation server only the measurements that are required to
> +verify the TPM quote, its workflow would be the following.
> +
> +With staging with prompt, the agent stages the current measurements list=
,
> +reads and stores the measurements in a storage and immediately requests
> +IMA to delete the staged measurements from kernel memory. Afterwards, it
> +calculates N by replaying the PCR extend on the stored measurements unti=
l
> +the calculated PCRs match the quoted PCRs. It then keeps the measurement=
s
> +in excess for the next attestation request.



> +
> +At the next attestation request, the agent performs the same steps above=
,
> +and concatenates the new measurements to the ones in excess from the
> +previous request. Also in this case, the agent replays the PCR extend un=
til
> +it matches the currently quoted PCRs, keeps the measurements in excess a=
nd
> +presents the new N measurement records to the remote attestation server.
> +
> +With the staging and deleting method, the agent reads the current
> +measurements list, calculates N and requests IMA to delete only those. T=
he
> +measurements in excess are kept in the IMA measurements list and can be
> +retrieved at the next remote attestation request.
> +
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +
> +The IMA staging mechanism can be enabled from the kernel configuration w=
ith
> +the CONFIG_IMA_STAGING option. This option prevents inadvertently removi=
ng
> +the IMA measurement list on systems which do not properly save it.
> +
> +If the option is enabled, IMA duplicates the current securityfs
> +measurements interfaces (both binary and ASCII), by adding the ``_staged=
``
> +file suffix. Both the original and the staging interfaces gain the write
> +permission for the root user and group, but require the process to have
> +CAP_SYS_ADMIN set.
> +
> +The staging mechanism supports two flavors.
> +
> +
> +Staging with prompt
> +~~~~~~~~~~~~~~~~~~~
> +
> +The current measurements list is moved to a temporary staging area,
> +allowing it to be saved to external storage, before being deleted upon
> +confirmation.
> +
> +This staging process is achieved with the following steps.
> +
> + 1. ``echo A > <_staged interface>``: the user requests IMA to stage the
> +    entire measurements list;
> + 2. ``cat <_staged interface>``: the user reads the staged measurements;
> + 3. ``echo D > <_staged interface>``: the user requests IMA to delete
> +    staged measurements.
> +
> +
> +Staging and deleting
> +~~~~~~~~~~~~~~~~~~~~
> +
> +N measurements are staged to a temporary staging area, and immediately
> +deleted without further confirmation.
> +
> +This staging process is achieved with the following steps.
> +
> + 1. ``cat <original interface>``: the user reads the current measurement=
s
> +    list and determines what the value N for staging should be;
> + 2. ``echo N > <original interface>``: the user requests IMA to delete N
> +    measurements from the current measurements list.
> +
> +
> +Interface Access
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In order to avoid the IMA measurements list being suddenly truncated by =
the
> +staging mechanism during a read, or having multiple concurrent staging, =
a
> +semaphore-like locking scheme has been implemented on all the measuremen=
ts
> +list interfaces.
> +
> +Multiple readers can access concurrently the original and staged
> +interfaces, and they can be in mutual exclusion with one writer. In orde=
r
> +to see the same state across all the measurement interfaces, the same
> +writer is allowed to open multiple interfaces for write or read/write.
> +
> +If an illegal access occurs, the open to the measurements list interface=
 is
> +denied.
> +
> +
> +Kexec
> +=3D=3D=3D=3D=3D
> +
> +In the event a kexec() system call occurs between staging and deleting, =
the
> +staged measurement records are marshalled before the current measurement=
s
> +list, so that they are both available when the secondary kernel starts.
> +
> +If measurement is suspended before requesting to delete staged or curren=
t
> +measurements, IMA returns an error to user space to let it know that
> +marshalling is already in progress, so that it does not save the
> +measurements twice.
> +
> +IMA also disallows staging when suspending measurement, to avoid the
> +situation where neither measurements are carried over to the secondary
> +kernel, nor they are saved by user space to the storage.
> +
> +
> +Hash table
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +By default, the template digest of staged measurement records are kept i=
n
> +kernel memory (only template data are freed), to be able to detect
> +duplicate records independently of staging.
> +
> +The new kernel option ``ima_flush_htable`` has been introduced to
> +explicitly request a complete deletion of the staged measurements, for
> +maximum kernel memory saving. If the option has been specified, duplicat=
e
> +records are still avoided on records of the current measurements list,
> +but there can be duplicates between different groups of staged
> +measurements.
> +
> +Flushing the hash table is supported only for the staging with prompt
> +flavor. For the staging and deleting flavor, it would have been necessar=
y
> +to lock the hot path adding new measurements for the time needed to remo=
ve
> +each selected measurement individually.
> diff --git a/Documentation/security/index.rst b/Documentation/security/in=
dex.rst
> index 3e0a7114a862..00650dcf38cb 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -8,6 +8,7 @@ Security Documentation
>     credentials
>     snp-tdx-threat-model
>     IMA-templates
> +   IMA-export-delete
>     keys/index
>     lsm
>     lsm-development
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 461a3eed6129..70ff6bae3493 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12752,6 +12752,8 @@ R:	Eric Snowberg <eric.snowberg@oracle.com>
>  L:	linux-integrity@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integri=
ty.git
> +F:	Documentation/security/IMA-export-delete.rst
> +F:	Documentation/security/IMA-templates.rst
>  F:	include/linux/secure_boot.h
>  F:	security/integrity/
>  F:	security/integrity/ima/

