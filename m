Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7B4F9850
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiDHOmO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiDHOmN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 10:42:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F220EDF3A;
        Fri,  8 Apr 2022 07:40:10 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238CdSGD014989;
        Fri, 8 Apr 2022 14:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XFkL8cQvSYvUcpOEfCXPe12HKR8iBPHrQbnrpfQWjC0=;
 b=g4U7cBLoLPGHbXBOqk9l26ROGil4abM9xP/Wn9F7FtavnQ1LtZ235EK0ZBis9Id6gAQL
 S548VI3cfxgPrzlHySNtWc/NBxge8wvIk+UKcO8oto++7j69Ab2lE3niJOTbAfp3dEDd
 trqIUZeJGVYlxYUGRVrE+fJOExi5zaK557yCcuj/ScP+L2PrhwFCGpU/sjGdJRFa29nw
 K0zFqisuL6oIHF+zNSmEeTRWRBzkvZSj30wOCg9dF3HDRzpQPcsuKPzGShqmFT8ZMGTw
 Bzj0dATouwuStchWo0a/NIpmrqEzQR3EwpODlpUMm8ufx3yuNtMCZJ+79SIfQzYUctLL 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fac23n6fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:39:34 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238EKeiD019963;
        Fri, 8 Apr 2022 14:39:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fac23n6en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:39:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238EbCGe032743;
        Fri, 8 Apr 2022 14:39:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhuyk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:39:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238EdSdK49217800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 14:39:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DD474C046;
        Fri,  8 Apr 2022 14:39:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A2CD4C044;
        Fri,  8 Apr 2022 14:39:26 +0000 (GMT)
Received: from sig-9-65-90-167.ibm.com (unknown [9.65.90.167])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Apr 2022 14:39:26 +0000 (GMT)
Message-ID: <b28ea211d88e968a5487b20477236e9b507755f4.camel@linux.ibm.com>
Subject: Re: [PATCH 2/7] KEYS: X.509: Parse Basic Constraints for CA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        pvorel@suse.cz, tiwai@suse.de, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 08 Apr 2022 10:39:25 -0400
In-Reply-To: <20220406015337.4000739-3-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <20220406015337.4000739-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jMHn25ub1MQrcehXfpQCUpPiLWReHYqc
X-Proofpoint-ORIG-GUID: mmpsduc6xbiX_CRWDs2sqDmNMf1PYHOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> Parse the X.509 Basic Constraints.  The basic constraints extension
> identifies whether the subject of the certificate is a CA.
> 
> BasicConstraints ::= SEQUENCE {
>         cA                      BOOLEAN DEFAULT FALSE,
>         pathLenConstraint       INTEGER (0..MAX) OPTIONAL }
> 
> If the CA is true, store it in the x509_certificate.  This will be used
> in a follow on patch that requires knowing if the public key is a CA.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
>  crypto/asymmetric_keys/x509_parser.h      | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 2899ed80bb18..30f7374ea9c0 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -583,6 +583,15 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_basicConstraints) {
> +		if (vlen < 2 || v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
> +			return -EBADMSG;
> +		if (v[1] != vlen - 2)
> +			return -EBADMSG;
> +		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
> +			ctx->cert->is_root_ca = true;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> index 97a886cbe01c..dc45df9f6594 100644
> --- a/crypto/asymmetric_keys/x509_parser.h
> +++ b/crypto/asymmetric_keys/x509_parser.h
> @@ -38,6 +38,7 @@ struct x509_certificate {
>  	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
>  	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
>  	bool		blacklisted;
> +	bool		is_root_ca;		/* T if basic constraints CA is set */

There's no need to prefix variables with "is_".  Similar to the
variable "self_signed" simply name this variable "root_ca".

thanks,

Mimi


>  };
>  
>  /*


