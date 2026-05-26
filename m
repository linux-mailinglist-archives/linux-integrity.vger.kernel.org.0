Return-Path: <linux-integrity+bounces-9682-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JjOAunMFWq6bwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9682-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 18:40:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3C5D9DC3
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317A530CCF88
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6C38D3E8;
	Tue, 26 May 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VJ442wSP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E738D3FB;
	Tue, 26 May 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810824; cv=none; b=OHOLoOoPsHsLQw+hbDKo+fi5EMM4L1Jj6IcQlZzcaKDhAn41TilKdcZHJI740oti87HqsdfVxCVyHjL8wRzCeI6KG8/o+hioZM3icdLYEgsj8FH+IqcnrHGqSQnCca88fH0f1TM5cqAaPiJ1/cW4tpGKo/dCNaEjXPAGHva2rLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810824; c=relaxed/simple;
	bh=flxaglZfHiOD94CaHEK91bF8xE2z/fiF0zmU4cfjKnc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=WHcmtWP3EyohE4RR6hlQTj8d6+WOiR8gvFyBxVWl8iGLJ9x0VhAB4OITYjgUFHpCMO4rzTo0rwNWUlnL6Y+mJH0oQN4N+AJx5HKaFml9ooCjXZK414PfjK8N0fecFuu/XOxLXsDBs0OmcLYTUK+RZf+yp/d2KWe7YQJoP7cdKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VJ442wSP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QBJfDu2678824;
	Tue, 26 May 2026 15:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KL4xFE
	SqBTmI7g4zeMcj/1QMLNo0qqoM3qkESn6OWN8=; b=VJ442wSPyqwR1MyXI7AVIS
	kv8DI7HOGwHEdA1BbI2RQjiZrObSt9lwQN6tZWl9oNuWUdlGKwjo7OjMWMUg4KdV
	HQ/jxWJfz/cdOhd6DL3ZJ2jLI+wblNy8qQ9yzezQD0N9W6oDqNS3gVsrvWcY/s+w
	TG3I8SDr8VKHhuffFUDlqL71Hf5/C8mgeRNv/K0E3GEtZi61AlQWGgtpggpgXN82
	v/pnOicFmk+ig61TLa0pN3miYH0bwg33TKcdO7oq+tNPtpTFTJZcq1X+1VLev2hI
	i67CsZlYH4OZDJkhxhhn2DbvCEZ+IH05y7rMNOtdiaCPbSlq6GQmCuTkAMO2bd6Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nun42j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 15:53:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QFdf03020502;
	Tue, 26 May 2026 15:53:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebpjqa8yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 15:53:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QFrJYF29688326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 15:53:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA165804B;
	Tue, 26 May 2026 15:53:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 653FE58055;
	Tue, 26 May 2026 15:53:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.63.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 15:53:17 +0000 (GMT)
Message-ID: <34e13ef20eb507f6025dd9f1138df0a862f5110e.camel@linux.ibm.com>
Subject: Re: [PATCH v5 13/13] doc: security: Add documentation of the IMA
 staging mechanism
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-14-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 11:53:16 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNCBTYWx0ZWRfX0AKKSIYvJKZf
 IxHJVY6hUKPfn30s6VfOyfpj6s07Z6e9oghkaayJxSZOUXXCkBw6gLaMVE50/HdAWi9Zg0EVS8S
 LyBMFKaNUYLsJc05CLgj9IjQOOFljEXmI5M7bqQfYJFVMDirtssX/3Z1QK+8P3QlgHwJRPNCmrU
 xFMgtYzt4o+fzksCiS7gCQOdlqKK/v0jki1qYA4vFS2LCtHoihNr6K2kpWrXO6IndL7sdreX6dC
 r3v/Dyy0gUHRkTpujhsr0u1S+Hm2KWGAbaWtf2HfbNy8PU/RIf+SPWybQzb8gEuivWA+BnW6VO/
 kWgMgK4eAMeHUv9Eou820dPyrANjvMyz0OrI89g9x2f4CFttNyQuavjJho9u21NuxiMkVohxSe2
 EErR0d/40roewsVY/oCvgRG/0P6UNqOcZdpUCax5FVd9xMfBcA9vt7RTRoCG3wxRsUfvdo8Ydi9
 xTt+F78EYgsQjE78naw==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a15c1f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=2gXG2BVIBEAsA41MxPYA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: suwDQ4wSlnnFpe9LsUMFlGpKwBTjS-R0
X-Proofpoint-GUID: F4514dJzlJB76a9Vi21YBxWgrvlwJg1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260134
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9682-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,oracle.com:email,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5DA3C5D9DC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"staging" is a method of exporting and deleting IMA measurement list record=
s
from kernel memory. The Subject line and document should be more generic. P=
lease
update the Subject line to something like "ima: exporting and deleting IMA
measurement records from kernel memory".

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Add the documentation of the IMA staging mechanism in
> Documentation/security/IMA-staging.rst.

Please update the name.

>=20
> Also add the missing Documentation/security/IMA-templates.rst file in
> MAINTAINERS.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  Documentation/security/IMA-staging.rst | 163 +++++++++++++++++++++++++
>  Documentation/security/index.rst       |   1 +
>  MAINTAINERS                            |   2 +
>  3 files changed, 166 insertions(+)
>  create mode 100644 Documentation/security/IMA-staging.rst
>=20
> diff --git a/Documentation/security/IMA-staging.rst b/Documentation/secur=
ity/IMA-staging.rst
> new file mode 100644
> index 000000000000..de6428893f0e
> --- /dev/null
> +++ b/Documentation/security/IMA-staging.rst
> @@ -0,0 +1,163 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +IMA Measurements Staging Mechanism
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

Please update the name here as well.  The introduction describes the motiva=
tion
for the feature of exporting and deleting measurement records.  The concept=
 of
"staging" measurement records to be deleted should be described later.

> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The IMA measurements list is currently stored in the kernel memory. Memo=
ry
> +occupation grows linearly with the number of entries, and can become a
> +problem especially in environments with reduced resources.
> +
> +While there is an advantage in keeping the IMA measurements list in kern=
el
> +memory, so that it is always available for reading from the securityfs
> +interfaces, storing it elsewhere would make it possible to free precious
> +memory for other kernel components.
> +
> +Storing the IMA measurements list outside the kernel does not introduce
> +security issues, since its integrity is anyway protected by the TPM.
> +
> +Hence, the new IMA staging mechanism is introduced to allow user space
> +to remove the desired portion of the measurements list from the kernel.

Please incorporate my previous comments on 00/13 here and, perhaps, add mor=
e
details (e.g. userspace application for saving and returning the complete
measurement list).

Introduce the concept of "staging" here. (There's quite a bit of code neede=
d for
staging the measurement list.)  Please include an explanation of the stagin=
g
benefits (e.g. locking).

> +
> +
> +Usage
> +=3D=3D=3D=3D=3D

Readers need to understand the implications of enabling the CONFIG_IMA_STAG=
ING
feature, before telling them how to enable it.  Either move the "Usage" sec=
tion
to after "Management of Staged Measurements" and "Remote Attestation Agent
Workflow" or introduce the concepts here would be better.

> +
> +The IMA staging mechanism can be enabled from the kernel configuration w=
ith
> +the CONFIG_IMA_STAGING option.

Referring to exporting and deleting mechanism from here on as "staging" is =
fine.

thanks,

Mimi

> +
> +If it is enabled, IMA duplicates the current measurements interfaces (bo=
th
> +binary and ASCII), by adding the ``_staged`` file suffix. Both the origi=
nal
> +and the staging interfaces gain the write permission for the root user a=
nd
> +group, but require the process to have CAP_SYS_ADMIN set.
> +
> +The staging mechanism supports two flavors.
> +
> +
> +Staging with prompt
> +~~~~~~~~~~~~~~~~~~~
> +
> +The current measurements list is moved to a temporary staging area, and
> +staged measurements are deleted upon confirmation.
> +
> +This staging process is achieved with the following steps.
> +
> + 1. ``echo A > <original interface>``: the user requests IMA to stage th=
e
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
> +In order to avoid the IMA measurements list be suddenly truncated by the
> +staging mechanism during a read, or having multiple concurrent staging, =
a
> +semaphore-like locking scheme has been implemented on all the measuremen=
ts
> +list interfaces.
> +
> +Multiple readers can access concurrently the original and staged
> +interfaces, and they can be in mutual exclusion with one writer.
> +
> +If an illegal access occurs, the open to the measurements list interface=
 is
> +denied.
> +
> +
> +Management of Staged Measurements
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Since with the staging mechanism measurement entries are removed from th=
e
> +kernel, the user needs to save the staged ones in a storage and concaten=
ate
> +them together, so that it can present them to remote attestation agents =
as
> +if staging was never done.
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
> +presents the new N measurements entries to the remote attestation server=
.
> +
> +With the staging and deleting method, the agent reads the current
> +measurements list, calculates N and requests IMA to delete only those. T=
he
> +measurements in excess are kept in the IMA measurements list and can be
> +retrieved at the next remote attestation request.
> +
> +Kexec
> +=3D=3D=3D=3D=3D
> +
> +In the event a kexec() system call occurs between staging and deleting, =
the
> +staged measurements entries are prepended to the current measurements li=
st,
> +so that they are both available when the secondary kernel starts. In tha=
t
> +case, IMA returns an error to the user when attempting to delete staged
> +measurements to notify about their copy to the kexec buffer, so that the
> +user does not store them twice.
> +
> +
> +Hash table
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +By default, the template digest of staged measurement entries are kept i=
n
> +kernel memory (only template data are freed), to be able to detect
> +duplicate entries independently of staging.
> +
> +The new kernel option ``ima_flush_htable`` has been introduced to
> +explicitly request a complete deletion of the staged measurements, for
> +maximum kernel memory saving. If the option has been specified, duplicat=
e
> +entries are still avoided on entries of the current measurements list,
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
> index 3e0a7114a862..cec064dc1c83 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -8,6 +8,7 @@ Security Documentation
>     credentials
>     snp-tdx-threat-model
>     IMA-templates
> +   IMA-staging
>     keys/index
>     lsm
>     lsm-development
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..5bc816ab4a5b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12740,6 +12740,8 @@ R:	Eric Snowberg <eric.snowberg@oracle.com>
>  L:	linux-integrity@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integri=
ty.git
> +F:	Documentation/security/IMA-staging.rst
> +F:	Documentation/security/IMA-templates.rst
>  F:	include/linux/secure_boot.h
>  F:	security/integrity/
>  F:	security/integrity/ima/

