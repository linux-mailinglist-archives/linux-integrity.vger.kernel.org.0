Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2785419313
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Sep 2021 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhI0L3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Sep 2021 07:29:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233948AbhI0L3G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Sep 2021 07:29:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RBH9Gq009251;
        Mon, 27 Sep 2021 07:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jXvrqG/pK/EG/1k6diP9NW5ornENCC97YX+sh9Hwmvk=;
 b=pXTJbNDkre9oldiT0B0MLSxP9N8SMQFAxfUcO4hFQYxFsz2ybKz4SCeXaO4kRGuWBDc9
 RAaBa2FRImsjwt39QPiqfk6YH9aQuebjG0se32UxRpxrq4C92zW6zu2mUkQpdO12F+CW
 23foSCo2wepzSj3eDMGIAiMcCRgMTt+CgiDZd25X0U8zkB9COmtP2S23fAOjr7YlVQAj
 vO/D5i5M/6ThXobAJUaHj2N5U8eWJ+68o4OMZ5BgkxvS27SPZrLf2myVYHa38bn7zQeP
 nakNGDqdHVa/PlDSHFrvvzvXCK1MpU5pK0zraL+EaSzSUZwQj7256qLft1iwFqKPLgVZ Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbark3200-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 07:27:13 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18RBRDfB019816;
        Mon, 27 Sep 2021 07:27:13 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbark31ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 07:27:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18RBDE9d028488;
        Mon, 27 Sep 2021 11:27:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3b9u1j46ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 11:27:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18RBR8hn65536282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 11:27:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9965F52065;
        Mon, 27 Sep 2021 11:27:08 +0000 (GMT)
Received: from sig-9-65-214-62.ibm.com (unknown [9.65.214.62])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C7A1652063;
        Mon, 27 Sep 2021 11:27:05 +0000 (GMT)
Message-ID: <856359f263575f01d0ce2fcf8f042321f750b38c.camel@linux.ibm.com>
Subject: Re: [PATCH v3] KEYS: trusted: Fix trusted key backends when
 building as module
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Andreas Rammhold <andreas@rammhold.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Sep 2021 07:27:04 -0400
In-Reply-To: <20210927085104.vq42feghtaqiv6ni@wrt>
References: <20210730012822.3460913-1-andreas@rammhold.de>
         <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
         <20210927085104.vq42feghtaqiv6ni@wrt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QJJQKuPvR8AdPEhBR82xAwkKMDK5eaBi
X-Proofpoint-GUID: qhGXlaO4FS7Mt2HHRv_t-mcV73Yxgmg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_04,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-09-27 at 10:51 +0200, Andreas Rammhold wrote:
> On 09:47 13.09.21, Ahmad Fatoum wrote:
> > Dear trusted key maintainers,
> > 
> > On 30.07.21 03:28, Andreas Rammhold wrote:
> > > Before this commit the kernel could end up with no trusted key sources
> > > even though both of the currently supported backends (TPM and TEE) were
> > > compiled as modules. This manifested in the trusted key type not being
> > > registered at all.
> > > 
> > > When checking if a CONFIG_… preprocessor variable is defined we only
> > > test for the builtin (=y) case and not the module (=m) case. By using
> > > the IS_REACHABLE() macro we do test for both cases.
> > > 
> > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Does anyone intend to pick this up?
> 
> Did this end up in any tree by now? I am wondering if I should resend
> the patch instead. Perhaps it was just overlooked?

For EVM environments only using trusted and encrypted keys, not file
signatures, the trusted key is needed to decrypt the "master" key in
order to verify kernel modules.

Mimi


