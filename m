Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747362C856
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2019 16:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfE1OKK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 10:10:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbfE1OKK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 10:10:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SE9p2P065728
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 10:10:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ss5ktjthh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 10:10:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 28 May 2019 15:09:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 15:09:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SE9XAf34406474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 14:09:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 606A0AE053;
        Tue, 28 May 2019 14:09:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FED4AE051;
        Tue, 28 May 2019 14:09:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.224])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 May 2019 14:09:31 +0000 (GMT)
Subject: Re: [PATCH v10 12/12] ima: Store the measurement again when
 appraising a modsig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date:   Tue, 28 May 2019 10:09:20 -0400
In-Reply-To: <20190418035120.2354-13-bauerman@linux.ibm.com>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-13-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052814-4275-0000-0000-0000033962A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052814-4276-0000-0000-000038490AD0
Message-Id: <1559052560.4090.14.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280092
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thiago,

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> If the IMA template contains the "modsig" or "d-modsig" field, then the
> modsig should be added to the measurement list when the file is appraised.
> 
> And that is what normally happens, but if a measurement rule caused a file
> containing a modsig to be measured before a different rule causes it to be
> appraised, the resulting measurement entry will not contain the modsig
> because it is only fetched during appraisal. When the appraisal rule
> triggers, it won't store a new measurement containing the modsig because
> the file was already measured.
> 
> We need to detect that situation and store an additional measurement with
> the modsig. This is done by adding an IMA_MEASURE action flag if we read a
> modsig and the IMA template contains a modsig field.

With the new per policy rule "template" support being added, this
patch needs to be modified so that the per policy "template" format is
checked.  ima_template_has_modsig() should be called with the
template_desc being used.

thanks,

Mimi


> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8e6475854351..f91ed4189f98 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -282,9 +282,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  		/* read 'security.ima' */
>  		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
>  
> -		/* Read the appended modsig if allowed by the policy. */
> -		if (iint->flags & IMA_MODSIG_ALLOWED)
> -			ima_read_modsig(func, buf, size, &modsig);
> +		/*
> +		 * Read the appended modsig, if allowed by the policy, and allow
> +		 * an additional measurement list entry, if needed, based on the
> +		 * template format.
> +		 */
> +		if (iint->flags & IMA_MODSIG_ALLOWED) {
> +			rc = ima_read_modsig(func, buf, size, &modsig);
> +
> +			if (!rc && ima_template_has_modsig())
> +				action |= IMA_MEASURE;
> +		}
> 

