Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A205A5746
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH2WwT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 18:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2WwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 18:52:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B17C7E308
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 15:52:18 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMU2jj030512;
        Mon, 29 Aug 2022 22:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BDq7XeiFHx5KNlNDVExk99jQsTR+ix2qHOeLj2wZXok=;
 b=oajM55paMMBuOT55OYV97Jom9XFzVVrWKXoi2ZFRoLOhTylhyv8RKhQaelIy2wnvwgaT
 zVfS3pHUWiNPDi+YqjvBOxzQ49oh7UJn7kRrNxuMiFUTE1e80NBU2PsLZ5SzTshSo51u
 Vf3gp6+NG6yNg1dH0M11KldJmm3X1WHQQ2QXPxfaIVle+PP7vTR8DRjU58A9LMaB+V3N
 kfpxTrfsLoZn08ght8I/RBIJ5h724pPCVmQj989Jf3F2mQquQUGCA3GpLYdJQJ0sOj2O
 PJ0N1wg61/JqIRo8FgBZ/Qj1QO4Z6YdJqa9k2Qtj9Ze7ZTO5iKUiFzaq9xpALxP3YtLV tg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j96a8rn9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 22:52:12 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27TMo33X018470;
        Mon, 29 Aug 2022 22:52:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3j7aw9bx78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 22:52:11 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27TMqAoq16909206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 22:52:10 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE6692805C;
        Mon, 29 Aug 2022 22:52:10 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B7B28058;
        Mon, 29 Aug 2022 22:52:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.117.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 22:52:10 +0000 (GMT)
Message-ID: <3a9702fda8411705091705af9896cd08cecac580.camel@linux.ibm.com>
Subject: Re: [PATCH v4 ima-evm-utils 2/3] Sign an fs-verity file digest
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
Date:   Mon, 29 Aug 2022 18:52:09 -0400
In-Reply-To: <3ba337f8-8c1c-025e-a510-2fd1616f51d0@linux.ibm.com>
References: <20220617192107.270865-1-zohar@linux.ibm.com>
         <20220617192107.270865-3-zohar@linux.ibm.com>
         <3ba337f8-8c1c-025e-a510-2fd1616f51d0@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hNLTABZjFROEL6tvh-lNnD3ukuB_b1iR
X-Proofpoint-ORIG-GUID: hNLTABZjFROEL6tvh-lNnD3ukuB_b1iR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208290099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2022-06-19 at 20:34 -0400, Stefan Berger wrote:
> 
>  
> > -	/* support reading hash (eg. output of shasum) */
> >   	while ((len = getline(&line, &line_len, stdin)) > 0) {
> >   		/* remove end of line */
> >   		if (line[len - 1] == '\n')
> >   			line[--len] = '\0';
> >   
> > -		/* find the end of the hash */
> > -		token = strpbrk(line, ", \t");
> > -		hashlen = token ? token - line : strlen(line);
> > +		/*
> > +		 * Before either directly or indirectly signing the hash,
> > +		 * convert the hex-ascii hash representation to binary.
> > +		 */
> > +		if (veritysig) {
> > +
> > +			/* split the algorithm from the hash */
> > +			hashp = strpbrk(line, ":");
> > +			if (hashp)	/* pointer to the delimiter */
> > +				algolen = hashp - line;
> > +
> > +			if (!hashp || algolen <= 0 ||
> > +			    algolen >= sizeof(algo)) {
> > +				log_err("Missing/invalid fsverity hash algorithm\n");
> > +				continue;
> > +			}
> > +
> > +			strncpy(algo, line, algolen);
> > +			algo[algolen] = '\0';	/* Nul terminate algorithm */
> > +
> > +			hashp++;
> > +			token = strpbrk(line, ", \t");
> 
> I haven't run this so I don't know the output but maybe the code should 
> show what the expected line looks like. That strpbrk is looking for any 
> one  of ',', ' ', and '\t' is ok? And the start of the search should be 
> line and cannot be hashp ?
> token == NULL check?

> > +/*
> > + * Calculate the signature format version 3 hash based on the portion
> > + * of the ima_file_id structure used, not the entire structure.
> > + *
> > + * For openssl errors return 1, other errors return -EINVAL.
> 
> Returns the legth of the hash otherwise.
> 
> 
>    With the two nits fixed:
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.  I've addressed both of the issues.  This patch set and
other ci/travis changes are in next-testing.

Mimi

