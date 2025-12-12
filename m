Return-Path: <linux-integrity+bounces-7936-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 537FFCB8543
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Dec 2025 09:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 116DB3003F5C
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Dec 2025 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936202868B2;
	Fri, 12 Dec 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZHs1iW9I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25B18A6AD
	for <linux-integrity@vger.kernel.org>; Fri, 12 Dec 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529450; cv=none; b=dZketiolHs7DUqQljn1Q2jJTofSDx6uzoTxi5msViFPlz3WN1mCnLMQHP3rdLnGtGQU21TgAkwhTT8JaRZUeiSTFv3Uwo4Zn99chTIZvEEHQJOG8zSiBMWU6ZCGFXdJYLJ60W3CR2USzTGH/If/7LlW822Ww9tRBm7SFQzzDKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529450; c=relaxed/simple;
	bh=gP5iARDEhOlbF1iGEITtwQjV9UwAYIFGg10Y0uux4ik=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MpFPHHmNm2t+qO0ufg5LEK9xLghPTVfPKpx2Es5bkuvFsEHPJoh8dV91IN8qF8HwSIqW/iF7t1lUpdzzwBSa7BebeYiWH8s7FnGMMjRlb+xCJt4XQvbRsBJPGwPufGjcbkNmm/Z6MexlbabQBfPDeOr730iiolENKj3+UHFV7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZHs1iW9I; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso6188335e9.1
        for <linux-integrity@vger.kernel.org>; Fri, 12 Dec 2025 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765529445; x=1766134245; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMbPdYY8hhjSf1UINe5DZjuxa7jzdORA7oILKRZrGQY=;
        b=ZHs1iW9IXh1eGl0vETwvybhZfiO2GlCnLe7cfnLa/WM/JOa3C7+FWqwy9v3LHKGevg
         JLEhYYBKjHiAnJiyu45TupPs9VE3htmYhFfo7AEAnBAGB9YXoQDNJxSPVUfHyKi/OLE9
         sLmdPiEPzOH3PB1gdWWvg5wrzCTdATEl/jkEUI/OJKiUmPYg6zwrzADU5ZnjyeKNKWrv
         o0v4I5xMTXJmfOGWLiYMRFsFP3bbx9qTWKqvTS4zt0ow5XX2LJfc7gpxgd+AAtHizMdl
         5jwXxiCm5CCfS8khxu9GRu73U8Y+Md8FzHbg2M6I7FOFxjn3RM/eq6uHXi9VPglJ9flu
         YXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529445; x=1766134245;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMbPdYY8hhjSf1UINe5DZjuxa7jzdORA7oILKRZrGQY=;
        b=gnWW88pa66zd/ZEPdkmSlDBUeDrYxU6hNIlKQNGndKUoqkZNnKPEsGBDxNYl0wxF0i
         etY+giZZDODPlEwiQt7oZ7I+JMa6pkq2JYL9vhP1KXhch8ePP2Lci5a5TaAqVQXmuvg1
         P7TkK6p9GotjCxdiURJfDUwS73SQ9ZLa5h87w6wW2/Re9PTU5O1C+f3jU4n8CLWYoDgu
         mRj/OQTl9+o398a809z+fy1xvv97wPKD6IEg5hgmE7QHvo69WOSpUpKo0SxrT8435FPx
         PRpr81iuxjvZ5XGQQCf9huHqI2rcE+HTBEieTkAlRyyrfZLpy4wJU+kHKvPod7XFGHRh
         ZHXg==
X-Gm-Message-State: AOJu0YwYRiRAQMWpc8zG2J1tF0UJWF4j6oqYGH3Y2W63Sw25GPywW0hD
	II4dNK3kkJoKE3DEjWsHJk1dE/dKuEphLR+RgAQ5sPWm5BfGXBg5ElU4AZEoNBGrz5Ty6u77KvE
	DrWNRxOc=
X-Gm-Gg: AY/fxX6bpLfBIEtaS41kKpQ/g3yx/pBD5oGthDv77fv3lgEgsb2N2iI8xgnWhYwvhb4
	oMpPJjCYDdhLuAroONfzLOn6RPi/vD3I9MLyfVlb6Mu8I2llsk221D6w05Y8VDTPFlafsvVpKfm
	LlvzYcfBiUC2qk6GYCezEzMaPfxFltHhxNGaTXhZ27SAE3RBWiL5se9Vfkev9jqv5BPSbcfbUM5
	zIOZt/6gLBVnGlRfWS2rRisYGXJfTFrpYjCAB0kOlxVtvhtlKBx2Yx8FkiKT7vMgThKrChvcIrz
	vkv3uWJKMeB+HLFIwkUGOt9L7tYv8rixp8ik+Npkoo3uvr1kZLXUUG6tWDCjAjy7y4FVncDQZtq
	BPfELNPFFxtmygXp0W87s0kGvJYAS/YmVKjX2lI+dBzMy73WQ4cfg0d6Ncc5zFkG9akRQki8TOc
	UboRc1ZqfUaZ5CgXgCUqs=
X-Google-Smtp-Source: AGHT+IHf64SbPewUIVKnFcsOR3pZ6Nc/bZ27kUpb1X6IhV9YxemjEIm+F5msk/lMD8DTC9dFV2ChXg==
X-Received: by 2002:a05:600d:844f:10b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47a90019d50mr7404895e9.21.1765529444889;
        Fri, 12 Dec 2025 00:50:44 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a66b1fsm11374379f8f.9.2025.12.12.00.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 00:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 09:50:43 +0100
Message-Id: <DEW3YDE8MMBT.DEEW2VO31X0G@suse.com>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [LTP] [PATCH] ima_violations.sh: Another fix of condition
 evaluation
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251211111046.87297-1-pvorel@suse.cz>
In-Reply-To: <20251211111046.87297-1-pvorel@suse.cz>

Hi!

On Thu Dec 11, 2025 at 12:10 PM CET, Petr Vorel wrote:
> c0c35509f9 was not enough to fix evaluation against empty
> $expected_violations:
>
> ima_violations 1 TINFO: verify open writers violation
> /opt/ltp/testcases/bin/ima_violations.sh: line 96: [: 0: unary operator e=
xpected
>
> Therefore split checks into two if.
>
> Also improvements (readability)
> * shorten line length with saving subtraction into variable
> * evaluate empty variable with ${:-}
>
> Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support multi=
ple violations")
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: this was found on old SLES 4.4 based kernel which does not log
> validations. But missing validations might be just a Secure Boot related
> setup problem:
>
> $ mokutil --sb-state
> Secure Boot: EFI variables not supported on SUT
>
> Events are logged when Secure Boot is off:
> $ mokutil --sb-state
> SecureBoot disabled
>
> Or maybe violations worked differently on the old kernel (I remember
> only 6.15 change).
>
> Kind regards,
> Petr
>
>  .../integrity/ima/tests/ima_violations.sh     | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations=
.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 1d2f1d9447..a8476e6b59 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -87,23 +87,30 @@ validate()
>  	local search=3D"$3"
>  	local expected_violations=3D"$4"
>  	local max_attempt=3D3
> -	local count2 i num_violations_new
> +	local count2 diff i num_violations_new pass
> =20
>  	for i in $(seq 1 $max_attempt); do
>  		read num_violations_new < $IMA_VIOLATIONS
>  		count2=3D"$(get_count $search)"
> -		if [ -z "$expected_violations" -a $(($num_violations_new - $num_violat=
ions)) -gt 0 ] || \
> -		   [ $(($num_violations_new - $num_violations)) -eq $expected_violatio=
ns ]; then
> -			[ -z "$expected_violations" ] && expected_violations=3D1
> +		diff=3D$(($num_violations_new - $num_violations))
> +
> +		if [ "$expected_violations" ] && [ $diff -eq $expected_violations ]; t=
hen
> +			pass=3D1
> +		fi
> +		if [ -z "$expected_violations" ] && [ $diff -gt 0 ]; then
> +			pass=3D1
> +		fi

Maybe readability can be improved (well..shell scripts are pretty ugly
by nature anyway):

	diff=3D$((num_violations_new - num_violations))

	if [ "$expected_violations" ]; then
		[ $diff -eq $expected_violations ] && pass=3D1
	else
		[ $diff -gt 0 ] && pass=3D1
	fi

> +
> +		if [ "$pass" =3D 1 ]; then
>  			if [ $count2 -gt $count ]; then
> -				tst_res TPASS "$expected_violations $search violation(s) added"
> +				tst_res TPASS "${expected_violations:-1} $search violation(s) added"
>  				return
>  			else
>  				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..=
."
>  				tst_sleep 1s
>  			fi
> -		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
> -			tst_res $IMA_FAIL "$search too many violations added: $num_violations=
_new - $num_violations"
> +		elif [ $diff -gt 0 ]; then
> +			tst_res $IMA_FAIL "$search too many violations added: $diff ($num_vio=
lations_new - $num_violations)"
>  			return
>  		else
>  			tst_res $IMA_FAIL "$search violation not added"

--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


